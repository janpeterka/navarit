module Feedback
  class Admin::PostsController < AdminController
    before_action :load_post, only: %i[close complete reopen]

    def index
      @posts = Feedback::Post.all

      @posts = @posts.where(status: params[:status].to_sym) if params[:status].present?
    end

    def close
      @post.close

      redirect_back_or_to feedback.admin_posts_path, status: :see_other, notice: "Post has been closed."
    end

    def complete
      @post.complete

      redirect_back_or_to feedback.admin_posts_path, status: :see_other, notice: "Post has been completed."
    end

    def reopen
      @post.reopen

      redirect_back_or_to feedback.admin_posts_path, status: :see_other, notice: "Post has been reopened."
    end

    private

    def load_post
      @post = Feedback::Post.find(params[:id])
    end
  end
end
