require "rails_helper"

RSpec.describe Cart, type: :model do
  subject { build(:cart) }

  describe "associations" do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:products).through(:cart_items) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:session_token) }
  end
end
