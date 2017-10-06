class CreateStorageProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :storage_providers do |t|
      t.belongs_to :storage
      t.belongs_to :provider
      t.timestamps
    end
  end
end
