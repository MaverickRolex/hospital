require 'rails_helper'

RSpec.describe Storage, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:storage)).to be_valid
    end

    it "is not valid without a storage item name" do
      expect(build(:storage, item_name: nil)).to_not be_valid
    end

    it "is not valid if already exist" do
      item = create(:storage, item_name: "Storage Item")
      expect(build(:storage, item_name: "Storage Item")).to_not be_valid
    end
  end

  describe "asociations" do
    it "has many item_transfers" do
      assc = described_class.reflect_on_association(:item_transfers)
      expect(assc.macro).to eq :has_many
    end
  end

end
