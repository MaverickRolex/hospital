class CreateItemTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :item_transfers do |t|
      t.integer :item_id
      t.integer :origin_dep_id
      t.integer :destiny_dep_id
      t.integer :quantity
      t.timestamps
    end
  end
end
