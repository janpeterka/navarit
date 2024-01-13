class Feedback::Comment < Feedback::ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true

  validates :content, presence: true
end
