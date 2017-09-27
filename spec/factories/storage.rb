FactoryGirl.define do
  factory :storage do
    sequence(:item_name) { |n| "Item Name#{n}" }

    trait :storage_item_updated do
      item_name "Storage Item"
    end
  end
end