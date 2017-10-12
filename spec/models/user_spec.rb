require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:user, :system_manager_user)).to be_valid
    end
    it "is not valid without email" do
      expect(build(:user, email: nil)).to_not be_valid
    end
    it "is not valid without password" do
      expect(build(:user, password: nil)).to_not be_valid
    end
    it "is not valid without password_confirmation" do
      expect(build(:user, password_confirmation: nil)).to_not be_valid
    end
  end

  describe "asociations" do
    it "has_many sign_ins" do
      assc = described_class.reflect_on_association(:sign_ins)
      expect(assc.macro).to eq :has_many
    end
    it "has_many days_asigneds" do
      assc = described_class.reflect_on_association(:days_asigneds)
      expect(assc.macro).to eq :has_many
    end
    it "belongs_to department" do
      assc = described_class.reflect_on_association(:department)
      expect(assc.macro).to eq :belongs_to
    end
  end

end