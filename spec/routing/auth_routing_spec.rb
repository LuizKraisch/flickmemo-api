# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :routing do
  describe 'routing' do
    it 'route to #access' do
      expect(post: 'api/v1/auth/access').to route_to('api/v1/auth#access')
    end
  end
end
