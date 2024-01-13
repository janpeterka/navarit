class Feedback::Comment < Feedback::ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: 'User', foreign_key: :user_id, optional: true

  validates :content, presence: true

  def content_with_creator_info
    "#{creator&.name} commented: \n\n#{content}"
  end

  def upload!
    Feedback::CommentUploader.new.perform(id)
  end
end
