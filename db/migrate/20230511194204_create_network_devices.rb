class CreateNetworkDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :network_devices do |t|
      t.string :name
      t.string :d_type
      t.integer :ports
      t.integer :bandwidth
      t.float :price
      t.integer :sfp
      t.integer :sfp_plus
    end
  end
end
