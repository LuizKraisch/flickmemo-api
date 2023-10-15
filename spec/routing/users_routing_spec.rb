# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :routing do
  describe 'routing' do
    it 'route to #show' do
      expect(get: 'api/v1/users/1').to route_to('api/v1/users#show', id: '1')
    end

    it 'route to #destroy' do
      expect(delete: 'api/v1/users/1').to route_to('api/v1/users#destroy', id: '1')
    end

    it 'route to #recent' do
      expect(get: 'api/v1/users/1/recent').to route_to('api/v1/users#recent', id: '1')
    end

    it 'route to #watchlist' do
      expect(get: 'api/v1/users/1/watchlist').to route_to('api/v1/users#watchlist', id: '1')
    end

    it 'route to #favorites' do
      expect(get: 'api/v1/users/1/favorites').to route_to('api/v1/users#favorites', id: '1')
    end
  end
end
