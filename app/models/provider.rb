class Provider < ApplicationRecord
  enum priority: [:contract, :individual_sale]
  has_many :storages, through: :storage_providers
  has_many :storage_providers

  validates :name, uniqueness: true
  
  before_validation :set_name

  scope :active, -> { where(active: true) }

  def set_name
    if Provider.where(name: self.name).count > 0
      self.name = "#{self.name}_1"
    end
  end

  def self.find_by_product_prioritized(item_id)
    self.joins(storage_providers: :storage).
      where("providers.priority = 0")
  end
end