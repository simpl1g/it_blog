class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false, uniq: true

      t.timestamps
    end

    add_index :users, :login
  end
end
