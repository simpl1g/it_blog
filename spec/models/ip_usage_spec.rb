# frozen_string_literal: true

require 'rails_helper'

describe IpUsage, type: :model do
  context '.used_more_than_once' do
    let(:params) { { title: 'title', ip: '192.168.1.1', body: 'body', login: 'login' } }
    before do
      PostCreator.new(params).create_post
      PostCreator.new(params.merge(login: 'login2')).create_post
      PostCreator.new(params.merge(ip: '192.168.1.2')).create_post
    end

    it 'returns highest ranked posts' do
      expect(described_class.used_more_than_once.pluck(:ip)).to eq(['192.168.1.1'])
    end
  end
end