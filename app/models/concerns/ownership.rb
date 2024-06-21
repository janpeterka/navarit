module Ownership
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, polymorphic: true
  end

  def owner_sgid
    owner&.to_sgid(for: :polymorphic_select, expires_in: nil)
  end

  def owner_sgid=(new_owner_sgid)
    self.owner = GlobalID::Locator.locate_signed(new_owner_sgid, for: :polymorphic_select)
  end
end
