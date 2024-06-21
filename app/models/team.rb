class Team < ApplicationRecord
  has_many :memberships
  has_many :members, class_name: "User", through: :memberships

  def to_s = name

  def create_and_join(user)
    transaction do
      self.save
      memberships.create!(user:)
    end
  end
end
