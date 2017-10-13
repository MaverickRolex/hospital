class ItemTransfer < ApplicationRecord

  validates :storage_oper_user_id, presence: true
  validates :item_id, presence: true
  validates :destiny_dep_id, presence: true
  validates :quantity, presence: true

  belongs_to :storage_oper, class_name: "User", foreign_key: :storage_oper_user_id
  belongs_to :trans_requester, class_name: "User", foreign_key: :trans_request_user_id, optional: true
  belongs_to :storage, class_name: "Storage", foreign_key: :item_id
  belongs_to :origin_dep, class_name: "Department", foreign_key: :origin_dep_id, optional: true
  belongs_to :destiny_dep, class_name: "Department", foreign_key: :destiny_dep_id

  def from_provider?
    origin_dep_id.nil?
  end

end
