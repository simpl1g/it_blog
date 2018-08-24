# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    it 'returns 200 with valid params' do
      post :create, params: { title: 'test', ip: '192.168.1.1', login: 'test', body: 'test' }

      expect(response).to have_http_status(200)
    end

    it 'returns 422 with invalid params' do
      post :create

      expect(response).to have_http_status(422)
    end
  end
end
