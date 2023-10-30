class User < ActiveRecord
  has_many :roles, through: :user_roles
  has_many :daily_plans
  has_many :recipes
  has_many :ingredients
  has_many :events
  # has_many :events_in_role, through: :user_event_roles, source: :event
  has_many :portion_types
end
