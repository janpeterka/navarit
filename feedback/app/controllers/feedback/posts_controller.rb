class Feedback::PostsController < Feedback::ApplicationController
  before_action :load_post, only: %i[show]

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

  def show; end

  def synchronize
    @post = Feedback::Post.find(params[:post_id])

    @post.synchronize! if Feedback.synchronization_backend.present?

    redirect_back_or_to @post, status: :see_other
  end

  private

  def load_post
    @post = Feedback::Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description)
  end
end
