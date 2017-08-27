class Storage < ApplicationRecord

  validates :item_name, presence: { message: "The item name field can't be blank" }
  validates :item_name, uniqueness: { message: "The item has already been registered" }

  has_many :item_transfers

end
