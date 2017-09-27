FactoryGirl.define do
  factory :user do
    password "123456"
    password_confirmation "123456"
  end

  trait :system_manager_user do
    email "system_admin@test.com"
    department { build(:department, :dep_system_manager) }
    sistem_manager true
  end

  trait :storage_user do
    sequence(:email) { |n| "storage#{n}@test.com" }
    department { build(:department, :dep_storage) }
    sistem_manager false
  end

  trait :generic_user do
    email "generic@test.com"
    department { build(:department) }
    sistem_manager false
  end
end