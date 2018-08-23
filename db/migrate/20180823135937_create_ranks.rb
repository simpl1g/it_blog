class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.references :post, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
