# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_validation :set_created_by, on: :create

  def set_created_by
    self.created_by = Current.user.id if Current.user && respond_to?(:created_by)
    self.author = Current.user if Current.user && respond_to?(:author)
  end
end
