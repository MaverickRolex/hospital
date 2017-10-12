class AddUserFieldToItemTransfers < ActiveRecord::Migration[5.0]
  def change
    add_column :item_transfers, :user_id, :integer
  end
end
