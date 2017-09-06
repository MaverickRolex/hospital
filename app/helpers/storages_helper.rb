module StoragesHelper
  def item_quantity(item_id, dep_id)
    orig = ItemTransfer.where(item_id: item_id, origin_dep_id: dep_id).sum(:quantity)
    dest = ItemTransfer.where(item_id: item_id, destiny_dep_id: dep_id).sum(:quantity)
    quant = dest - orig
  end
end
