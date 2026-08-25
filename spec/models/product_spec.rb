require "rails_helper"

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:order_items) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

  describe "Publishable" do
    it "está publicado cuando published_at ya pasó" do
      expect(build(:product, published_at: 1.day.ago)).to be_published
    end

    it "no está publicado sin published_at" do
      expect(build(:product, :unpublished)).not_to be_published
    end
  end

  describe "trait :out_of_stock" do
    it "tiene stock cero" do
      expect(build(:product, :out_of_stock).stock).to eq(0)
    end
  end
end
