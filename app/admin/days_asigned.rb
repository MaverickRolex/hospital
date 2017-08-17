ActiveAdmin.register DaysAsigned do
  permit_params :user_id, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday

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
    column "User", :user_id do |asign|
      asign.user.user_full_name
    end
    column :monday
    column :tuesday
    column :wednesday
    column :thursday
    column :friday
    column :saturday
    column :sunday
    if current_user.sistem_manager?
      actions dropdown: true do |post|
      end
    end
  end

  filter :user_id, as: :select,
          collection: User.all.map {|user| [user.user_full_name, user.id]}
  filter :monday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :tuesday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :wednesday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :thursday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :friday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :saturday, as: :radio, collection: [["Yes", true], ["No", false]]
  filter :sunday, as: :radio, collection: [["Yes", true], ["No", false]]

  form do |f|
    f.inputs do
      f.input :user_id, as: :select,
              collection: User.all.map {|user| [user.user_full_name, user.id]}
      f.input :monday
      f.input :tuesday
      f.input :wednesday
      f.input :thursday
      f.input :friday
      f.input :saturday
      f.input :sunday 
    end
    f.actions
  end

end
