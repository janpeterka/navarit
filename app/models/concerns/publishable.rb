# frozen_string_literal: true

module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(is_shared: true) }
  end

  class_methods do
    def load_from_hash(hash)
      id = Base64.urlsafe_decode64(hash)
      find(id)
    rescue StandardError
      raise ActiveRecord::RecordNotFound
    end
  end

  def published?
    is_shared?
  end

  def publish!
    update(is_shared: true)
  end

  def unpublish!
    update(is_shared: false)
  end

  def public_url
    Rails.application.routes.url_helpers.send("published_#{self.class.name.downcase}_url", obfuscated_id)
  end

  private

  def obfuscated_id
    Base64.urlsafe_encode64(id.to_s)
  end
end
