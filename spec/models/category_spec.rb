require "rails_helper"

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to belong_to(:parent).class_name("Category").optional }
    it { is_expected.to have_many(:children).class_name("Category") }
    it { is_expected.to have_many(:products) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

  it "genera el slug a partir del name" do
    category = create(:category, name: "Ropa y Accesorios")
    expect(category.slug).to eq("ropa-y-accesorios")
  end
end
