# frozen_string_literal: true

class User < ApplicationRecord
  has_many :roles, through: :user_roles
  has_many :daily_plans
  has_many :recipes, foreign_key: :created_by
  has_many :ingredients, foreign_key: :created_by
  has_many :events, foreign_key: :created_by
  # has_many :events_in_role, through: :user_event_roles, source: :event
  has_many :portion_types

  def name
    full_name
  end

  def admin?
    true
  end
end
