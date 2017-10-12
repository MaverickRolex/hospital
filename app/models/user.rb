class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_many :item_transfer_operator, class_name: "ItemTransfer", foreign_key: :storage_oper
  has_many :item_transfer_requester, class_name: "ItemTransfer", foreign_key: :trans_requester
  has_many :sign_ins
  has_many :days_asigneds
  belongs_to :department
end
