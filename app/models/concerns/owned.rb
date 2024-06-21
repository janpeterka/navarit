module Owned
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, polymorphic: true
  end

  def change_owner(owner)
    return if owner.nil?
    return if self.owner == owner

    update(owner:)
  end
end
