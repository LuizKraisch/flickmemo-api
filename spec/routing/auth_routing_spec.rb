# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :routing do
  describe 'routing' do
    it 'routes to #access' do
      expect(get: 'api/v1/auth/access').to route_to('auth#access', id: '1')
    end
  end
end
