class Feedback::IndexController < Feedback::ApplicationController
  def show
    if current_user.respond_to?(:admin?) && current_user.admin?
      redirect_to admin_posts_url
    end

    @posts = Feedback::Post.created_by(current_user)
  end
end
