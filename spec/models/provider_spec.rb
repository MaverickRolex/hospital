require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "validations" do
    it "is valid" do
      expect(build(:provider)).to be_valid
    end
    it "is not valid if name already exists" do
      Provider.any_instance.stub(:set_name).and_return(true)
      create(:provider, name: "provider")
      expect { create(:provider, name: "provider") }.
        to raise_error(ActiveRecord::RecordInvalid)
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
    it "add _1_1 to name" do
      (1..2).each do
        create(:provider, name: "name")
      end
      object = create(:provider, name: "name")
      expect(object.name).to eql("name_1_1")
    end
    it "add _1_1_1 to name" do
      (1..3).each do
        create(:provider, name: "name")
      end
      object = create(:provider, name: "name")
      expect(object.name).to eql("name_1_1_1")
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

  describe "method" do
    before(:each) do
      @item = create(:storage)
      @primary = create(:provider, name: "primary", priority: 0)
      @secundary = create(:provider, name: "secundary", priority: 1)
      create(:storage_provider, storage: @item, provider: @primary)
      create(:storage_provider, storage: @item, provider: @secundary)
    end
    it "first priority provider return 'contract'" do
      list = Provider.find_by_product_prioritized(@item.id)
      expect(list.first.priority).to eq("contract")
    end
    it "last priority provider return 'individual_sale'" do
      list = Provider.find_by_product_prioritized(@item.id)
      expect(list.last.priority).to eq("individual_sale")
    end
    it "returns priority provider list" do
      expect(Provider.find_by_product_prioritized(@item.id)).to match_array([@primary, @secundary])
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
