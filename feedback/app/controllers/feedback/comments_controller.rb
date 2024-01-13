class Feedback::CommentsController < Feedback::ApplicationController
  before_action :load_post

  def index; end

  def create
    @comment = @post.comments.new(comment_params.merge(creator: current_user))

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Comment could not be created.', status: :unprocessable_entity
    end

    @comment.upload!
  end

  private

  def load_post
    @post = Feedback::Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
