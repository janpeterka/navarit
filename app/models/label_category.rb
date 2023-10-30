class LabelCategory < ActiveRecord
  has_many :labels

  validates :name, presence: true, uniqueness: true
end
