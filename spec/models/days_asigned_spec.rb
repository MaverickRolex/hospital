require 'rails_helper'

RSpec.describe DaysAsigned, type: :model do

  describe "asociations" do
    it "belongs_to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end

end