class Role < ActiveRecord
  validates :name, presence: true, uniqueness: true
end
