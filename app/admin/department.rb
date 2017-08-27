ActiveAdmin.register Department do
  permit_params :dep_name, :description

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
    column "Department", :dep_name
    column "Description", :description
    if current_user.sistem_manager?
      actions dropdown: true do |post|
      end
    end
  end

  filter :dep_name

end
