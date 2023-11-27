# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService, type: :service do
  describe '#find_or_create_by_google' do
    let(:user_data) do
      {
        google_user_uid: '12345',
        email: 'user@example.com',
        first_name: 'John Doe',
        photo_url: 'https://example.com/photo.jpg'
      }
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect do
          UserService.new.find_or_create_by_google(user_data)
        end.to change(User, :count).by(1)
      end

      it 'sets user attributes correctly' do
        user = UserService.new.find_or_create_by_google(user_data)
        expect(user).to have_attributes(
          google_user_uid: user_data[:google_user_uid],
          email: user_data[:email],
          first_name: 'John',
          last_name: 'Doe',
          photo_url: 'https://example.com/photo.jpg',
          preferred_language: 'pt-BR'
        )
      end
    end

    context 'when user already exists' do
      it 'does not create a new user' do
        existing_user = create(:user, google_user_uid: user_data[:google_user_uid], email: user_data[:email])

        expect do
          UserService.new.find_or_create_by_google(user_data)
        end.not_to change(User, :count)

        expect(User.find(existing_user.id)).to eq(existing_user)
      end
    end
  end
end
