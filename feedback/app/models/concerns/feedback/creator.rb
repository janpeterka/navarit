module Feedback::Creator
  extend ActiveSupport::Concern

  included do
    has_many :feedback_posts, class_name: 'Feedback::Post'
    has_many :feedback_notifications, class_name: 'Feedback::Notification'
  end
end
