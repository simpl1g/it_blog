class PostsController < ApplicationController
  def create
    if post_creator.create_post
      render json: post_creator.post
    else
      render json: post_creator.errors, status: 422
    end
  end

  private

  def post_creator
    @post_creator ||= PostCreator.new(post_params)
  end

  def post_params
    params.permit(:title, :body, :ip, :login).to_h.symbolize_keys
  end
end
