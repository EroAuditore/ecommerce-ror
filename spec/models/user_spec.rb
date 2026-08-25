require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "associations" do
    it { is_expected.to have_many(:carts) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:addresses) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  it "tiene role customer por default" do
    expect(User.new.role).to eq("customer")
  end

  it "no permite autenticarse si no está confirmado" do
    user = create(:user, :unconfirmed)
    expect(user.active_for_authentication?).to be false
  end
end
