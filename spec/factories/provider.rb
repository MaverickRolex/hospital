FactoryGirl.define do
  factory :provider do
    active true
    sequence(:address) { |n| "Address#{n}" }
    sequence(:name) { |n| "Name#{n}" }
    priority 0
  end
end
