module StoragesHelper
  def item_quantity(item_id, dep_id)

    quant_sql = ""
    ActiveRecord::Base.connection.execute(quant_sql)
    
    quant_sql = <<-SQL
      With items_from_origin AS (
        SELECT COALESCE(SUM(quantity), 0) FROM item_transfers
        WHERE item_transfers.item_id = #{item_id} AND item_transfers.origin_dep_id = #{dep_id}
      ),
      items_from_destiny AS (
        SELECT COALESCE(SUM(quantity), 0) FROM item_transfers
        WHERE item_transfers.item_id = #{item_id} AND item_transfers.destiny_dep_id = #{dep_id}
      )
      SELECT (SELECT * from items_from_destiny) - (SELECT * from items_from_origin) AS total_item
    SQL

    quant = ""
    ActiveRecord::Base.connection.execute(quant_sql).each do |row|
      quant = row
    end

    if quant["total_item"].blank?
      0
    else
      quant["total_item"]
    end

  end

  def total_item(item_id)
    total = 0
    @departments.each do |dep|
      total += item_quantity(item_id, dep.id)
    end
    total
  end
end
