# frozen_string_literal: true

module User::Omniauthable # rubocop:disable Style/ClassAndModuleChildren
  extend ActiveSupport::Concern

  class_methods do
    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data["email"]).first

      user ||= User.create(full_name: data["name"], email: data["email"], password: Devise.friendly_token(40))
      user
    end
  end
end
