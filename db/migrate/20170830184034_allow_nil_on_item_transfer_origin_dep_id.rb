class AllowNilOnItemTransferOriginDepId < ActiveRecord::Migration[5.0]
  def change
    change_column :item_transfers, :origin_dep_id, :integer, null: true
  end
end
