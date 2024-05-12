class Feedback::Comment < Feedback::ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: Feedback.creator_class.to_s, foreign_key: Feedback.creator_foreign_key.to_sym, optional: true

  has_many :notifications, as: :notifiable

  validates :content, presence: true

  def content_with_creator_info
    "#{creator&.name} commented: \n\n#{content}"
  end

  def upload!
    Feedback::CommentUploader.new.perform(id)
  end
end
