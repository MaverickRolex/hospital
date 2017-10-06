require 'rails_helper'

RSpec.describe ItemTransfer, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:item_transfer)).to be_valid
    end
    it "is not valid without item_id" do
      expect(build(:item_transfer, item_id: nil)).to_not be_valid
    end
    it "is not valid without destiny_dep_id" do
      expect(build(:item_transfer, destiny_dep_id: nil)).to_not be_valid
    end
    it "is not valid without quantity" do
      expect(build(:item_transfer, quantity: nil)).to_not be_valid
    end
  end

  describe "asociations" do
    it "belongs_to storage" do
      assc = described_class.reflect_on_association(:storage)
      expect(assc.macro).to eq :belongs_to
    end
    it "has many origin_dep" do
      assc = described_class.reflect_on_association(:origin_dep)
      expect(assc.macro).to eq :belongs_to
    end
    it "has many destiny_dep" do
      assc = described_class.reflect_on_association(:destiny_dep)
      expect(assc.macro).to eq :belongs_to
    end
  end

end