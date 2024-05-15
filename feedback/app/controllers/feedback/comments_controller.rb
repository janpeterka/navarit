class Feedback::CommentsController < Feedback::ApplicationController
  def show
    @comment = Feedback::Comment.find(params[:id])

    redirect_to @comment.post
  end

  def index; end

  def create
    @post = Feedback::Post.find(params[:post_id])

    @comment = @post.comments.new(comment_params.merge(creator: current_user))

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Comment could not be created.', status: :unprocessable_entity
    end

    @comment.upload! if Feedback.synchronization_backend.present?
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
