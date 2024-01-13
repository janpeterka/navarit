class Feedback::CommentUploader < Feedback::ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Feedback::Comment.find(comment_id)
    comment.upload!
  end
end
