ActiveAdmin.register User do
  permit_params :user_full_name, :department_id, :boss_department, :email, 
                :password, :password_confirmation, :sistem_manager

  controller do
    before_action :validate_permitions, only: [:new, :edit, :destroy]

    private

    def validate_permitions
      unless current_user.sistem_manager?
        flash[:error] = "You do not have permissions to perform this task"
        redirect_to admin_users_path
      end
    end
  end

  index do
    selectable_column
    id_column
    column "Name", :user_full_name
    column "Email", :email
    column "Department", :department_id do |dep|
      dep.department.dep_name
    end
    column "Boss Dep.", :boss_department
    column "Last Sign In", :current_sign_in_at
    if current_user.sistem_manager?
      actions dropdown: true do |post|
      end
    end
  end

  filter :user_full_name
  filter :email
  filter :boss_department

  form do |f|
    f.inputs do
      f.input :user_full_name
      f.input :department_id, as: :select,
              collection: Department.all.map {|dep| [dep.dep_name, dep.id]} 
      f.input :boss_department
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :sistem_manager
    end
    f.actions
  end

  show title: :user_full_name do
    div do
      attributes_table do
        row :email
        row :department_id
        row :boss_department
      end
    end
    panel "Log In Record" do
      table_for user.sign_ins do
        column :sign_in_at
      end
    end
  end

  sidebar "Laboral Days Asigned", only: :show do
    attributes_table_for user.days_asigneds do
      row :monday
      row :tuesday
      row :wednesday
      row :thursday
      row :friday
      row :saturday
      row :sunday
    end
  end

end
