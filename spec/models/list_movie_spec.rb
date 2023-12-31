# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListMovie, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:list) }
    it { is_expected.to belong_to(:movie) }
  end
end
