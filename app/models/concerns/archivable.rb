# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(is_archived: true) }
    scope :active, -> { where(is_archived: false) }
  end

  def archived?
    is_archived?
  end

  def archive!
    update(is_archived: true)
  end

  def restore!
    update(is_archived: false)
  end
end
