class Feedback::PostsController < Feedback::ApplicationController
  def index
    @posts = Feedback::Post.created_by(current_user)
  end

  def new; end

  def create
    @post = Feedback::Post.new(post_params.merge(creator: current_user))

    if @post.save
      redirect_to feedback.posts_path, status: :see_other
    else
      redirect_to feedback.posts_path, status: :unprocessable_entity
    end

    @post.upload! if Feedback.synchronization_backend.present?
  end

  def show
    @post = Feedback::Post.find(params[:id])

    unless current_user.in?([ @post.creator ] + Feedback.notifiable_admins)
      return redirect_to feedback_index_path
    end

    @post.mark_notifications_read(recipient: current_user)
  end

  def synchronize
    @post = Feedback::Post.find(params[:post_id])

    @post.synchronize! if Feedback.synchronization_backend.present?

    redirect_back_or_to @post, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:description)
  end
end
