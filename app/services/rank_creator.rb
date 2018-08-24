class RankCreator
  extend Dry::Initializer

  attr_reader :avg_rank

  option :post_id, default: -> { '' }
  option :rank,    default: -> { '' }, type: proc(&:to_i)

  Schema = Dry::Validation.Schema do
    configure { config.messages_file = 'config/locales/errors.yml' }

    required(:post_id).filled
    required(:rank).filled(:int?, gteq?: 1, lteq?: 5)

    validate(post: :post_id) { |post_id| Post.exists?(post_id) }
  end

  def create_rank
    return false unless validator.success?

    _create_rank

    true
  end

  def errors
    validator.messages
  end

  private

  def validator
    @validator ||= Schema.call(post_id: post_id, rank: rank)
  end

  def _create_rank
    post.with_lock do
      Rank.create!(post: post, value: rank)
      update_post_rank
    end
  end

  def post
    @post ||= Post.find(post_id)
  end

  def update_post_rank
    post.ranks_sum   += rank
    post.ranks_count += 1
    post.save!
    @avg_rank = format("%.2f", post.ranks_sum.to_f / post.ranks_count)
  end
end