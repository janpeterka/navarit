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
      p @post.errors
      redirect_to feedback.posts_path, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def post_params
    params.require(:post).permit(:description)
  end
end
