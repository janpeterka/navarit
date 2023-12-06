# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  def valid_password?(password)
    if Devise::Encryptor.compare(self.class, encrypted_password, password)
      true
    elsif flask_security_compare(password)
      self.password = password
      save!
      true
    else
      false
    end
  end

  private

  def flask_security_compare(password)
    legacy_salt = ENV['LEGACY_SECURITY_SALT']
    hashed_password = ::BCrypt::Engine.hash_secret(password, "$2a$12$#{legacy_salt[0..21]}")
    Devise.secure_compare(hashed_password, encrypted_password)
  end
end
