class AddUsersProcessOnItemTransfers < ActiveRecord::Migration[5.0]
  def change
    rename_column :item_transfers, :user_id, :storage_oper_user_id
    add_column :item_transfers, :trans_request_user_id, :integer
  end
end
