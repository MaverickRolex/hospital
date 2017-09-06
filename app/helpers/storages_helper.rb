module StoragesHelper
  def item_quantity(item_id, dep_id)
    orig = ItemTransfer.where(item_id: item_id, origin_dep_id: dep_id).sum(:quantity)
    dest = ItemTransfer.where(item_id: item_id, destiny_dep_id: dep_id).sum(:quantity)
    quant = dest - orig
  end

  def total_item(item_id)
    total = 0
    @departments.each do |dep|
      total += item_quantity(item_id, dep.id)
    end
    total
  end
end
