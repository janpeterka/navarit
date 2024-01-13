class Feedback::PostUploader < Feedback::ApplicationJob
  queue_as :default

  def perform(post_id)
    @post = Feedback::Post.find(post_id)

    connector = Feedback::Connectors::Github.new
    connector.upload_post(@post)

    @post.synchronize!
  end
end
