class Post < ApplicationRecord
  MIN_RANKS_COUNT = 1
  AVG_RANK = '(ranks_sum/ranks_count::decimal)'.freeze
  WITH_RANK = 'ranks_count > 0'.freeze

  has_many :ranks, dependent: :destroy
  belongs_to :user


  def self.top_by_rank(limit)
    select(:title, :body)
      .where(WITH_RANK)
      .order(Arel.sql "#{AVG_RANK} DESC")
      .limit(limit)
  end
end
