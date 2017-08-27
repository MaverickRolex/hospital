ActiveAdmin.register SignIn do
  
  permit_params :user_id, :sign_in_at

  index do
    selectable_column
    id_column
    column "User", :user_id do |user|
      user.user.user_full_name
    end
    column "Sign In At", :sign_in_at
    if current_user.sistem_manager?
      actions dropdown: true do |post|
      end
    end
  end

  filter :user_id
  filter :sign_in_at

end
