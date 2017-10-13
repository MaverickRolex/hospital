class Storage < ApplicationRecord

  validates :item_name, presence: true
  validates :item_name, uniqueness: true

  has_many :item_transfers, foreign_key: :item_id
  has_many :providers, through: :storage_providers
  has_many :storage_providers

  scope :find_items_with_providers, -> { joins(storage_providers: :provider) }

end
