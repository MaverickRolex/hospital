FactoryGirl.define do
  factory :storage do
    sequence :item_name do |n|
      "Item Name#{n}"
    end

    trait :storage_item_updated do
      item_name "Storage Item"
    end
  end
end