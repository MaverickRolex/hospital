FactoryGirl.define do
  factory :item_transfer do
    storage { create(:storage) }
    origin_dep_id nil
    destiny_dep { create(:department) }
    quantity 2
  end
end