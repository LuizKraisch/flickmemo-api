# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :routing do
  describe 'routing' do
    it 'route to #show' do
      expect(get: 'api/v1/movies/1').to route_to('api/v1/movies#show', id: '1')
    end

    it 'route to #search' do
      expect(get: 'api/v1/movies/search').to route_to('api/v1/movies#search')
    end

    it 'route to #similar' do
      expect(get: 'api/v1/movies/1/similar').to route_to('api/v1/movies#similar', id: '1')
    end

    it 'route to #discover' do
      expect(get: 'api/v1/movies/discover').to route_to('api/v1/movies#discover')
    end

    it 'route to #trending' do
      expect(get: 'api/v1/movies/trending').to route_to('api/v1/movies#trending')
    end
  end
end
