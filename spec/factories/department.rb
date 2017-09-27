FactoryGirl.define do
  factory :department do
    sequence :dep_name do |n|
      "Department Name#{n}"
    end
  end
end