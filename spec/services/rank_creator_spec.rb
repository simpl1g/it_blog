# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RankCreator, type: :unit do
  describe '#create_rank' do
    let(:post) do
      post_creator = PostCreator.new(
        title: 'test', ip: '192.168.1.1', login: 'test', body: 'test'
      )
      post_creator.create_post

      post_creator.post
    end
    let(:valid_params) do
      { post_id: post.id, rank: 3 }
    end
    let(:service) { described_class.new(params) }

    context 'performs validation' do
      context 'with invalid params' do
        let(:params) { {} }

        it 'returns errors' do
          expect(service).to_not receive(:_create_rank)
          expect(service.create_rank).to be_falsey
          expect(service.errors).to match(
            post_id: ['must be filled'],
            rank:    ['must be greater than or equal to 1', 'must be less than or equal to 5'],
          )
        end
      end

      context 'with valid params' do
        let(:params) { valid_params }

        it 'returns true' do
          expect(service).to receive(:_create_rank).and_return(true)
          expect(service.create_rank).to be_truthy
        end
      end
    end

    context 'saves changes in db' do
      let(:params) { valid_params }

      it 'accumulates rank' do
        service.create_rank
        post.reload

        expect(post.ranks_count).to  eq(1)
        expect(post.ranks_sum).to    eq(3)

        service.create_rank
        post.reload

        expect(post.ranks_count).to  eq(2)
        expect(post.ranks_sum).to    eq(6)
      end
    end
  end
end
