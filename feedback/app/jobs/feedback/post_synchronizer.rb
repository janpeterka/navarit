class Feedback::PostSynchronizer < Feedback::ApplicationJob
  queue_as :default

  def perform(post_id)
    @post = Feedback::Post.find(post_id)

    connector = Feedback::Connectors::Github.new
    connector.synchronize_post(@post)

    @post.update(last_synchronized_at: Time.zone.now)
  end
end
