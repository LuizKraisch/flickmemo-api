# frozen_string_literal: true

class UserService
  def find_or_create_by_google(data)
    @user = User.where(google_user_uid: data[:google_user_uid], email: data[:email]).first

    first_name, last_name = data[:first_name].split

    if @user.nil?
      User.create!(
        google_user_uid: data[:google_user_uid],
        email: data[:email],
        first_name:,
        last_name:,
        photo_url: data[:photo_url] || nil,
        preferred_language: 'pt-BR'
      )
    else
      @user
    end
  end
end
