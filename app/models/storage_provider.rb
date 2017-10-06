class StorageProvider < ApplicationRecord
  belongs_to :storage
  belongs_to :provider
end
