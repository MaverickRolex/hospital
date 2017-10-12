FactoryGirl.define do
  factory :storage_provider do
    storage { create(:storage) }
    provider { create(:provider) }
  end
end
