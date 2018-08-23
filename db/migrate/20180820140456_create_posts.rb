class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true

      t.string :title, null: false
      t.text   :body,  null: false
      t.inet   :ip,    null: false

      t.integer :ranks_count, default: 0, null: false
      t.integer :ranks_sum,   default: 0, null: false

      t.timestamps
    end
  end
end
