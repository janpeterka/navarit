# frozen_string_literal: true

module User::Omniauthable # rubocop:disable Style/ClassAndModuleChildren
  extend ActiveSupport::Concern

  class_methods do
    def from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      # Uncomment the section below if you want users to be created if they don't exist
      user ||= User.create(name: data['name'], email: data['email'], password: Devise.friendly_token[0, 20])
      user
    end
  end
end
