ActiveAdmin.register User do
  permit_params :user_full_name, :department_id, :boss_department, :email, 
                :password, :password_confirmation, :sistem_manager

  controller do
    def new
      if current_user.sistem_manager?
        @user = User.new
      else
        flash[:error] = "You do not have permissions to perform this task"
        redirect_to admin_users_path
      end
    end
    def edit
      if current_user.sistem_manager?
        @user = User.find(params[:id])
      else
        flash[:error] = "You do not have permissions to perform this task"
        redirect_to admin_users_path
      end
    end
    def destroy
      if current_user.sistem_manager?
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path
      else
        flash[:error] = "You do not have permissions to perform this task"
        redirect_to admin_users_path
      end
    end
  end

  index do
    selectable_column
    id_column
    column :user_full_name
    column :email
    column :department_id 
    column :boss_department
    column :current_sign_in_at
    column :sign_in_count
    if current_user.sistem_manager?
      actions
    end
  end

  filter :user_full_name
  filter :email
  filter :boss_department

  form do |f|
    f.inputs do
      f.input :user_full_name
      f.input :department_id 
      f.input :boss_department
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :sistem_manager
    end
    f.actions
  end

end
