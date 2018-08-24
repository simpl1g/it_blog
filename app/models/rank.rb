class Rank < ApplicationRecord
  MIN_RANK = 1
  MAX_RANK = 5

  belongs_to :post
end
