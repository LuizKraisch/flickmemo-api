# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'api/v1/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/users/1').to route_to('users#destroy', id: '1')
    end

    it 'routes to #recent' do
      expect(delete: 'api/v1/users/1/recent').to route_to('users#recent', id: '1')
    end

    it 'routes to #watchlist' do
      expect(delete: 'api/v1/users/1/watchlist').to route_to('users#watchlist', id: '1')
    end

    it 'routes to #favorites' do
      expect(delete: 'api/v1/users/1/favorites').to route_to('users#favorites', id: '1')
    end
  end
end
