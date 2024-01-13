class Feedback::IndexController < Feedback::ApplicationController
  def show
    @posts = Feedback::Post.created_by(current_user)
  end
end
