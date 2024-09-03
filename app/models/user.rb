# frozen_string_literal: true

class User < ApplicationRecord
  include User::Omniauthable
  include User::LegacyAuthentication # this makes migration from Flask-Security possible
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :roles, through: :user_roles
  has_many :daily_plans
  has_many :recipes, foreign_key: :created_by
  has_many :ingredients, foreign_key: :created_by
  has_many :events, foreign_key: :created_by
  has_many :user_event_roles, dependent: :destroy
  has_many :events_in_role, through: :user_event_roles, source: :event

  has_many :portion_types, foreign_key: :created_by
  has_many :recipe_reactions, class_name: "UserRecipeReaction"

  before_validation :set_legacy_columns, on: :create

  def collaborable_events
    Event.where(id: (self.events.pluck(:id) + self.events_in_role.pluck(:id)))
  end

  def name
    full_name
  end

  def initials
    full_name.split(" ").map(&:first).join.upcase
  end

  def admin?
    id == 1
  end
end
