FactoryGirl.define do
  factory :item_transfer do
    origin_dep_id nil
    quantity 2

    before(:create) do |item_transfer|
      item_transfer.storage = build(:storage)
      item_transfer.destiny_dep = build(:department)
    end
  end
end