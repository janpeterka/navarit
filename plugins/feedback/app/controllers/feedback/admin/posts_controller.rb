module Feedback
  class Admin::PostsController < AdminController
    before_action :load_post, only: %i[open close complete reopen]

    def index
      @posts = Feedback::Post.all

      if params[:status].present?
        @posts = @posts.where(status: params[:status].to_sym)
      else
        @posts = @posts.where(status: [:new, :open])
      end
    end

    def open
      @post.open!

      redirect_back_or_to feedback.admin_posts_path, status: :see_other, notice: "Post has been opened."
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
