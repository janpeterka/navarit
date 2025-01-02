class Feedback::CommentUploader < Feedback::ApplicationJob
  queue_as :default

  def perform(comment_id)
    @comment = Feedback::Comment.find(comment_id)

    connector = Feedback::Connectors::Github.new
    connector.upload_comment(@comment)
  end
end
