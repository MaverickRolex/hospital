require 'rails_helper'

RSpec.describe Department, type: :model do

  describe "validations" do
    it "is valid" do
      expect(build(:department)).to be_valid
    end

    it "is not valid with dep_name blank" do
      expect(build(:department, dep_name: nil)).to_not be_valid
    end

    it "is not valid if already exist" do
      item = create(:department, dep_name: "Department")
      expect(build(:department, dep_name: "Department")).to_not be_valid
    end
  end

  describe "asociations" do
    it "has many users" do
      assc = described_class.reflect_on_association(:users)
      expect(assc.macro).to eq :has_many
    end
    it "has many users" do
      assc = described_class.reflect_on_association(:origin_item_transfer)
      expect(assc.macro).to eq :has_many
    end
    it "has many users" do
      assc = described_class.reflect_on_association(:destiny_item_transfer)
      expect(assc.macro).to eq :has_many
    end
  end

end