# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'api/v1/reviews/1').to route_to('api/v1/reviews#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/reviews').to route_to('api/v1/reviews#create')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/reviews/1').to route_to('api/v1/reviews#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/reviews/1').to route_to('api/v1/reviews#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/reviews/1').to route_to('api/v1/reviews#destroy', id: '1')
    end
  end
end
