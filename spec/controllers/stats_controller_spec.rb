# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatsController, type: :controller do
  describe 'GET #top_by_rank' do
    it 'returns http success with valid params' do
      get :top_by_rank, params: { limit: 5 }

      expect(response).to have_http_status(:success)
    end

    it 'returns failure with invalid params' do
      get :top_by_rank

      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #ip_usage' do
    it 'returns http success' do
      get :ip_usage

      expect(response).to have_http_status(:success)
    end
  end
end
