class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.boolean :active
      t.text :address
      t.string :name
      t.integer :priority
      t.timestamps
    end
  end
end
