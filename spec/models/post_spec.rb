# frozen_string_literal: true

require 'rails_helper'

describe Post, type: :model do
  context '.top_by_rank' do
    let(:user) { User.create(login: 'login') }
    let(:params) { { title: 'title', ip: '192.168.1.1', body: 'body', user: user } }

    before do
      Post.create!(params.merge(ranks_count: 1, ranks_sum: 5, title: 'top post')) # avg = 5
      Post.create!(params.merge(ranks_count: 2, ranks_sum: 3))                    # avg = 1.5
      Post.create!(params.merge(ranks_count: 3, ranks_sum: 6))                    # avg = 2
      Post.create!(params.merge(ranks_count: 1, ranks_sum: 3, title: 'snd post')) # avg = 3
      Post.create!(params.merge(ranks_count: 2, ranks_sum: 5))                    # avg = 2.5
    end

    it 'returns highest ranked posts' do
      expect(described_class.top_by_rank(2).pluck(:title)).to eq(['top post', 'snd post'])
    end
  end
end