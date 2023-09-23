# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_and_belong_to_many(:movies) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:list_type) }

    it 'list type enum' do
      is_expected.to define_enum_for(:list_type).with({
                                                        watched: 'watched',
                                                        want_to_watch: 'want_to_watch'
                                                      })
    end
  end
end
