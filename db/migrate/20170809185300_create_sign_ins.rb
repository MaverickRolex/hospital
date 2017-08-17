class CreateSignIns < ActiveRecord::Migration[5.0]
  def change
    create_table :sign_ins do |t|
      t.integer :user_id
      t.datetime :sign_in_at
      t.timestamps
    end
  end
end
