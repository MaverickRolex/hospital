require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:provider)).to be_valid
    end
    it "is not valid uniqueness in name" do
      create(:provider, name: "provider")
      expect(build(:provider, name: "provider")).to_not be_valid
    end
  end

  describe "Callbacks" do
    it { is_expected.to callback(:set_name).before(:save) }
  end

  describe "priority" do
    it { is_expected.to define_enum_for(:priority) }
    it "enumerator value" do
      expect(build(:provider, priority: 0).priority).to eq("contract")
    end
    it "enumerator value" do
      expect(build(:provider, priority: 1).priority).to eq("individual_sale")
    end
  end

  describe "scope" do    
    it "provider scope get all active true" do
      create_list(:provider, 10, active: true)
      create_list(:provider, 5, active: false)
      expect(Provider.active.count).to eq(10)
    end
  end

  describe "asociations" do
    it "has_many storage through storage_providers" do
      assc = described_class.reflect_on_association(:storages)
      expect(assc.macro).to eq :has_many
    end
    it "has many storage_providers" do
      assc = described_class.reflect_on_association(:storage_providers)
      expect(assc.macro).to eq :has_many
    end
  end
end
