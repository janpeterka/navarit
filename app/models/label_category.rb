class LabelCategory < ApplicationRecord
  has_many :labels

  validates :name, presence: true, uniqueness: true
end
