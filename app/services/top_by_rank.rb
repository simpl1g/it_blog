class TopByRank < ApplicationService
  param :limit, default: -> { 0 }, type: proc(&:to_i)

  Schema = Dry::Validation.Schema do
    required(:limit).filled(:int?, gteq?: Post::MIN_RANKS_COUNT)
  end

  def results
    return [] unless valid?

    Post.top_by_rank(limit)
  end

  private

  def validator
    @validator ||= Schema.call(limit: limit)
  end
end