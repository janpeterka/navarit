module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(is_shared: true) }
    scope :not_published, -> { where(is_shared: false) }
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

  def publishable?
    procedure.present? && !draft?
  end

  def publish!
    p "trying to publish: #{publishable?}"
    return unless publishable?

    update(is_shared: true)

    p "published"
  end

  def unpublish!
    return unless published?

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
