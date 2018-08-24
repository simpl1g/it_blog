# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostCreator, type: :unit do
  describe '#create_post' do
    let(:ip) { '192.168.1.1' }
    let(:valid_params) do
      { title: 'title', ip: ip, login: 'login', body: 'body' }
    end
    let(:service) { described_class.new(params) }

    context 'performs validation' do
      context 'with invalid params' do
        let(:params) { {} }

        it 'returns errors' do
          expect(service).to_not receive(:_create_post)
          expect(service.create_post).to be_falsey
          expect(service.errors).to match(
            title: ['must be filled'],
            body:  ['must be filled'],
            ip:    ['must be filled', 'has wrong IPv4 format'],
            login: ['must be filled']
          )
        end
      end

      context 'with valid params' do
        let(:params) { valid_params }

        it 'returns true' do
          expect(service).to receive(:_create_post).and_return(true)
          expect(service.create_post).to be_truthy
        end
      end
    end

    context 'saves changes in db' do
      let(:params) { valid_params }

      before { service.create_post }

      it 'saves post and user' do
        expect(service.post).to      eq(Post.find_by(title: 'title', body: 'body'))
        expect(service.post.user).to eq(User.find_by(login: 'login'))
      end

      context 'accumulates ip usage' do
        let(:usage) { IpUsage.find_by(ip: service.post.ip) }

        it do
          service.create_post
          expect(usage.reload.used_by).to eq(['login'])
          service.create_post
          expect(usage.reload.used_by).to eq(['login'])
          described_class.new({ title: 'title', ip: ip, login: 'login2', body: 'body' }).create_post
          expect(usage.reload.used_by).to eq(['login', 'login2'])
        end
      end
    end
  end
end
