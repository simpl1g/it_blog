class AddAvgSortingIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, Post::AVG_RANK, name: :posts_average_rank, where: Post::WITH_RANK
  end
end
