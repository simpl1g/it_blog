# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RanksController, type: :controller do
  describe 'POST #create' do
    let(:blogpost) do
      post_creator = PostCreator.new(
        title: 'test', ip: '192.168.1.1', login: 'test', body: 'test'
      )
      post_creator.create_post

      post_creator.post
    end

    it 'returns 200 with valid params' do
      post :create, params: { post_id: blogpost.id, rank: 2, format: :json }

      expect(response).to have_http_status(200)
    end

    it 'returns 422 with invalid params' do
      post :create, params: { post_id: 'test' }

      expect(response).to have_http_status(422)
    end
  end
end
