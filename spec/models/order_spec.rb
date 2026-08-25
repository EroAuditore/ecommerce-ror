require "rails_helper"

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to have_many(:products).through(:order_items) }
  end

  describe "enums" do
    it do
      expect(subject).to define_enum_for(:status)
        .with_values(pending: "pending", confirmed: "confirmed", shipped: "shipped",
                      delivered: "delivered", cancelled: "cancelled")
        .backed_by_column_of_type(:string)
    end

    it do
      expect(subject).to define_enum_for(:payment_status)
        .with_values(unpaid: "unpaid", paid: "paid", refunded: "refunded")
        .backed_by_column_of_type(:string)
    end
  end

  describe "trait :cancelled" do
    it "tiene status cancelled" do
      expect(build(:order, :cancelled)).to be_cancelled
    end
  end
end
