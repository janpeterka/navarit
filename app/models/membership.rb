class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  # enum :permission, %i[viewer collaborator owner]
end
