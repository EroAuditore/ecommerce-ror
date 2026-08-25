require "rails_helper"

RSpec.describe Address, type: :model do
  subject { build(:address) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  it "usa MX como country por default" do
    expect(Address.new.country).to eq("MX")
  end
end
