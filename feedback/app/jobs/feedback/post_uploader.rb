class Feedback::PostUploader < Feedback::ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Feedback::Post.find(post_id)
    post.upload!
  end
end
