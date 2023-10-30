class OAuth < ActiveRecord
  belongs_to :user

  validates :provider_user, presence: true
end
