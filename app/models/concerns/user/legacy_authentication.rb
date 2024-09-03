module User::LegacyAuthentication
  extend ActiveSupport::Concern

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

  def set_legacy_columns
    self.active = true
    self.fs_uniquifier = SecureRandom.hex(16)
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
end
