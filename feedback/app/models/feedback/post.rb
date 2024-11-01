class Feedback::Post < Feedback::ApplicationRecord
  belongs_to :creator, class_name: Feedback.creator_class.to_s, foreign_key: Feedback.creator_foreign_key

  has_many :comments
  has_many :notifications, as: :notifiable
  has_many_attached :attachments

  scope :created_by, ->(creator) { where(creator: creator) }

  validates :description, presence: true

  enum :status, %i[new open closed completed], default: :new, prefix: true

  after_create :notify_admins

  def title
    "Feedback ##{id} from #{creator.name}"
  end

  def synchronize!
    Feedback::PostSynchronizer.new.perform(id)
  end

  def upload!
    Feedback::PostUploader.new.perform(id)
  end

  def close
    status_closed!

    Feedback::Notification.create!(title: "Your feedback has been closed", notifiable: self, recipient: creator)
  end

  def complete
    status_completed!

    Feedback::Notification.create!(title: "Your feedback has been completed", notifiable: self, recipient: creator)
  end

  def open!  # ok, this is weird, but it seems like there's some private method `open` on ActiveRecord element or something
    status_open!

    Feedback::Notification.create!(title: "Your feedback has been taken into consideration by admins", notifiable: self, recipient: creator)
  end

  def reopen
    status_open!

    Feedback::Notification.create!(title: "Your feedback has been reopened", notifiable: self, recipient: creator)
  end

  def mark_notifications_read(recipient:)
    notifications.where(recipient:).mark_all_read!

    comments.each do |comment|
      comment.notifications.where(recipient:).mark_all_read!
    end
  end

  private

  def notify_admins
    Feedback.notifiable_admins.each do |admin|
      Feedback::Notification.create!(title: "New feedback from ##{creator.id}", notifiable: self, recipient: admin)
    end
  end
end
