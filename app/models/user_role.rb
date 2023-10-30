class UserRole < ActiveRecord
  belongs_to :user
  belongs_to :role
end
