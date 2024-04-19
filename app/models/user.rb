# frozen_string_literal: true

class User < ApplicationRecord
  include User::Omniauthable
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
  has_many :user_event_roles
  has_many :events_in_role, through: :user_event_roles, source: :event

  has_many :portion_types, foreign_key: :created_by

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
    true
  end

  def valid_password?(password)
    if Devise::Encryptor.compare(self.class, encrypted_password, password)
      true
    elsif legacy_valid_password?(password)
      self.password = password
      self.legacy_password = nil
      save!
      true
    else
      false
    end
  end

  # private

  def legacy_valid_password?(password)
    require "bcrypt"
    bcrypt_password = BCrypt::Password.new(legacy_password)

    hmaced_password = User.get_hmac(password)
    hashed_password = BCrypt::Engine.hash_secret(hmaced_password, bcrypt_password.salt)

    Devise.secure_compare(hashed_password, legacy_password)
  rescue BCrypt::Errors::InvalidHash
    false
  end

  def self.get_hmac(password)
    require "openssl"
    require "base64"

    salt = Rails.application.credentials.LEGACY_SECURITY_SALT || ENV["LEGACY_SECURITY_SALT"]

    raise "The configuration value `LEGACY_SECURITY_SALT` must not be None" if salt.nil?

    digest = OpenSSL::Digest.new("sha512")
    hmac = OpenSSL::HMAC.digest(digest, salt, password)
    Base64.encode64(hmac).chomp.gsub(/\n/, "")
  end

  def set_legacy_columns
    self.active = true
    self.fs_uniquifier = SecureRandom.hex(16)
  end
end
