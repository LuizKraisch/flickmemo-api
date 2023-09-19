# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  context 'index' do
    it 'should return status 200' do
      get api_v1_users_path

      expect(response).to have_http_status(200)
    end
  end
end
