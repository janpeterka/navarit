# frozen_string_literal: true

module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(is_shared: true) }
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
end
