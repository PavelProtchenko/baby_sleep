module Api
  module V1
    class PostsController < Api::V1::ApiController
      def index
        @last_updated_post = Post.order(updated_at: :desc).limit(1)
        @posts = Post.order(updated_at: :desc)

        if @posts.present? && params[:last_update]
          @last_updated_post
          @posts = Post.where('updated_at > ?', params[:last_update])
        elsif @posts.present?
          @last_updated_post
          @posts
        else
          head :no_content
        end
      end
    end
  end
end
