class StatsController < ApplicationController
  def top_by_rank
    if top_posts.valid?
      render json: top_posts.results.as_json(only: [:title, :body])
    else
      render json: top_posts.errors, status: 422
    end
  end

  def ip_usage
    render json: IpUsage.used_more_than_once.as_json(only: [:ip, :used_by])
  end

  private

  def top_posts
    @top_posts ||= TopByRank.new(params[:limit])
  end
end
