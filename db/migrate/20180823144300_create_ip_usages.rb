class CreateIpUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_usages do |t|
      t.string :ip, null: false, uniq: true
      t.text   :used_by, array: true, default: [], null: false
    end

    add_index :ip_usages, :ip
    add_index :ip_usages, IpUsage::USAGE_LENGTH, name: :ip_used_by_length
  end
end
