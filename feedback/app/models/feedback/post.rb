class Feedback::Post < Feedback::ApplicationRecord
  has_many :comments
  belongs_to :creator, class_name: Feedback.creator_class.to_s, foreign_key: :creator_id

  scope :created_by, ->(creator) { where(creator: creator) }

  validates :description, presence: true

  enum :status, %i[open closed completed], default: :open, prefix: true

  def title
    "Feedback ##{id} from #{creator.name}"
  end

  def synchronize!
    Feedback::PostSynchronizer.new.perform(id)
  end

  def upload!
    Feedback::PostUploader.new.perform(id)
  end
end
