require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "validations" do
    it "is valid" do
      expect(build(:provider)).to be_valid
    end
    it "is not valid if name already exists" do
      create(:provider, name: "provider")
      expect(build(:provider, name: "provider")).to_not be_valid
    end
  end

  describe "Callbacks" do
    it { is_expected.to callback(:set_name).before(:validation) }
    it "validation is true" do
      object = create(:provider, name: "name")
      expect(object.name).to eql("name")
    end
    it "add _1 to name" do
      create(:provider, name: "name")
      object = create(:provider, name: "name")
      expect(object.name).to eql("name_1")
    end
  end

  describe "priority" do
    it { is_expected.to define_enum_for(:priority) }
    it "returns 'contract' when priority = 0" do
      expect(build(:provider, priority: 0).priority).to eq("contract")
    end
    it "returns 'individual_sale' when priority = 1" do
      expect(build(:provider, priority: 1).priority).to eq("individual_sale")
    end
  end

  describe "scope" do    
    it "returns providers with 'active' = true" do
      create_list(:provider, 10, active: true)
      create_list(:provider, 5, active: false)
      expect(Provider.active.count).to eq(10)
    end
  end

  describe "asociations" do
    it "has_many storages through storage_providers" do
      assc = described_class.reflect_on_association(:storages)
      expect(assc.macro).to eq :has_many
    end
    it "has many storage_providers" do
      assc = described_class.reflect_on_association(:storage_providers)
      expect(assc.macro).to eq :has_many
    end
  end
end
