require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'class methods' do
    it "#search_by_name" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, name: "Box fan")
      item_2 = create(:item, merchant_id: merchant.id, name: "Boxing gloves")
      item_3 = create(:item, merchant_id: merchant.id, name: "Wheelbarrow")
      item_4 = create(:item, merchant_id: merchant.id, name: "Candy bar")

      expect(Item.search_by_name('box')).to eq([item_1, item_2])
      expect(Item.search_by_name('bar')).to eq([item_4, item_3])
      expect(Item.search_by_name('fan')).to eq([item_1])
    end

    it "#search_max_price" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, name: "Box fan", unit_price: 19.99)
      item_2 = create(:item, merchant_id: merchant.id, name: "Boxing gloves", unit_price: 39.99)
      item_3 = create(:item, merchant_id: merchant.id, name: "Wheelbarrow", unit_price: 59.99)

      expect(Item.search_max_price(20.00)).to eq([item_2, item_3])
    end
  end
end
