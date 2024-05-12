module Feedback
  class Notification < ApplicationRecord
    belongs_to :recipient, class_name: Feedback.creator_class.to_s, foreign_key: Feedback.creator_foreign_key.to_sym
    belongs_to :notifiable, polymorphic: true

    scope :unread, -> { where(read_at: nil) }

    def mark_read!
      update!(read_at: Time.zone.now)
    end
  end
end
