# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(is_archived: true) }
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
