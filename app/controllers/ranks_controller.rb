class RanksController < ApplicationController
  def create
    if rank_creator.create_rank
      render json: rank_creator.avg_rank
    else
      render json: rank_creator.errors, status: 422
    end
  end

  private

  def rank_creator
    @rank_creator ||= RankCreator.new(post_params)
  end

  def post_params
    params.permit(:post_id, :rank).to_h.symbolize_keys
  end
end
