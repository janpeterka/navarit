class Feedback::Post < Feedback::ApplicationRecord
  has_many :comments
  belongs_to :creator, class_name: 'User', foreign_key: :user_id

  scope :created_by, ->(user) { where(creator: user) }

  validates :description, presence: true

  enum :status, %i[open closed completed], default: :open, prefix: true

  def title
    "Feedback ##{id} from #{creator.name}"
  end

  def synchronize!
    @connector = Feedback::Connectors::Github.new
    @connector.synchronize_post(self)

    update(last_synchronized_at: Time.zone.now)
  end

  def upload!
    @connector = Feedback::Connectors::Github.new
    @connector.upload_post(self)

    synchronize!
  end

  def issue_comments
    @connector = Feedback::Connectors::Github.new
    @connector.comments(self)
  end
end
