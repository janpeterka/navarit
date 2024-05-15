class Feedback::Comment < Feedback::ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: Feedback.creator_class.to_s, foreign_key: Feedback.creator_foreign_key.to_sym, optional: true

  has_many :notifications, as: :notifiable

  validates :content, presence: true

  after_save :notify

  def content_with_creator_info
    "#{creator&.name} commented: \n\n#{content}"
  end

  def description
    content.truncate(50)
  end

  def upload!
    Feedback::CommentUploader.new.perform(id)
  end

  private

  def notify
    if creator != post.creator
      # admin response
      notifications.create!(recipient: post.creator, title: "Admin commented your feedback!", notifiable: self)
    else
      admins_in_thread.each do |admin|
        notifications.create!(recipient: admin, title: "Author reacted to your comment", notifiable: self)
      end
    end
  end

  def admins_in_thread
    Feedback.notifiable_admins.intersection(post.comments.map(&:creator).uniq)
  end
end
