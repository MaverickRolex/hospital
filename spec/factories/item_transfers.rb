FactoryGirl.define do
  factory :item_transfer do
    storage { build(:storage) }
    origin_dep_id nil
    destiny_dep { build(:department) }
    quantity 2
  end
end