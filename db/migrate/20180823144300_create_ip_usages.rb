class CreateIpUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_usages do |t|
      t.inet :ip, null: false, uniq: true
      t.text :used_by, array: true, default: [], null: false
    end

    add_index :ip_usages, :ip
    add_index :ip_usages, 'array_upper(used_by, 1)', name: :ip_used_by_length
  end
end
