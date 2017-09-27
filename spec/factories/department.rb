FactoryGirl.define do
  factory :department do
    sequence(:dep_name) { |n| "Department Name#{n}" }

    trait :dep_system_manager do
      dep_name "System Manager"
    end

    trait :dep_storage do
      dep_name "Storage"
    end
  end
end