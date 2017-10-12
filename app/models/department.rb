class Department < ApplicationRecord

  validates :dep_name, presence: true
  validates :dep_name, uniqueness: true

  has_many :users
  has_many :origin_item_transfer, class_name: "ItemTransfer", foreign_key: :origin_dep
  has_many :destiny_item_transfer, class_name: "ItemTransfer", foreign_key: :destiny_dep

end
