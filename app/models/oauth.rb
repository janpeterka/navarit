# frozen_string_literal: true

class Oauth < ApplicationRecord
  belongs_to :user

  validates :provider_user, presence: true
end
