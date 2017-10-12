require 'rails_helper'

RSpec.describe StorageProvider, type: :model do
  describe "asociations" do
    it "belongs_to storage" do
      assc = described_class.reflect_on_association(:storage)
      expect(assc.macro).to eq :belongs_to
    end
    it "belongs_to provider" do
      assc = described_class.reflect_on_association(:provider)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
