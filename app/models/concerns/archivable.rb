# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(is_archived: true) }
    scope :active, lambda {
                     where(is_archived: false).or(where(is_archived: nil))
                   } # TODO: as of now, is_archived can be NULL, so this is needed.
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
