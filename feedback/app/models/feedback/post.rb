class Feedback::Post < Feedback::ApplicationRecord
  belongs_to :creator, class_name: Feedback.creator_class.to_s, foreign_key: Feedback.creator_foreign_key

  has_many :comments
  has_many :notifications, as: :notifiable

  scope :created_by, ->(creator) { where(creator: creator) }

  validates :description, presence: true

  enum :status, %i[open closed completed], default: :open, prefix: true

  after_save :notify_admins

  def title
    "Feedback ##{id} from #{creator.name}"
  end

  def synchronize!
    Feedback::PostSynchronizer.new.perform(id)
  end

  def upload!
    Feedback::PostUploader.new.perform(id)
  end

  private

  def notify_admins
    p "Notifying admins"
    p Feedback.notifiable_admins
    Feedback.notifiable_admins.each do |admin|
      Feedback::Notification.create!(title: "New feedback from ##{creator.id}", notifiable: self, recipient: admin)
    end
  end
end
