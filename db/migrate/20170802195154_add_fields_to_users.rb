class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :user_full_name, :string
    add_column :users, :department_id, :integer
    add_column :users, :boss_department, :boolean
    add_column :users, :sistem_manager, :boolean
  end
end
