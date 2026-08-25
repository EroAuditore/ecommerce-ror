require "rails_helper"

RSpec.describe OrderItem, type: :model do
  subject { build(:order_item) }

  describe "associations" do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
end
