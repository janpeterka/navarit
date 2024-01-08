class Feedback::Post < Feedback::ApplicationRecord
  has_many :comments
  belongs_to :creator, class_name: 'User', foreign_key: :user_id

  scope :created_by, ->(user) { where(creator: user) }

  validates :description, presence: true

  enum :status, %i[open closed completed], default: :open, prefix: true

  def title
    "Feedback ##{id} from #{creator.name}"
  end
end
