FactoryGirl.define do
  factory :user do
    password "123456"
    password_confirmation "123456"
  end

  trait :operational_user do
    email "operate@tests.com"
    department_id Department.create(dep_name: "Storage").id
    sistem_manager false
  end

  trait :system_manager_user do
    email "system_admin@test.com"
    department_id Department.create(dep_name: "System Admin").id
    sistem_manager true
  end

  trait :storage_user do
    email "storage@test.com"
    department_id Department.create(dep_name: "Storage").id
    sistem_manager false
  end

  trait :generic_user do
    email "generic@test.com"
    department_id Department.create(dep_name: "Nurcery").id
    sistem_manager false
  end
end