class PortionType < ActiveRecord
  belongs_to :author, class_name: "User"

  validates :name, presence: true, uniqueness: true
  validates :size, presence: true, numericality: { greater_than: 0 }, default: 1

  scope :used, -> { joins(:portions).where("portions.id IS NOT NULL").distinct.any? }
end
