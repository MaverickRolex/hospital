class ItemTransfer < ApplicationRecord

  validates :item_id, presence: { message: "Invalid operation, select an item to transfer" }
  validates :destiny_dep_id, presence: { message: "Invalid operation, select destiny department" }
  validates :quantity, presence: { message: "Invalid operation, quantity can't be blank" }

  belongs_to :storage, class_name: "Storage", foreign_key: :item_id
  belongs_to :origin_dep, class_name: "Department", foreign_key: :origin_dep_id, optional: true
  belongs_to :destiny_dep, class_name: "Department", foreign_key: :destiny_dep_id

  def from_provider?
    origin_dep_id.nil?
  end

end
