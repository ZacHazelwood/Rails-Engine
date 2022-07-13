require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    it '#find_item_by_id' do
      merchant = create(:merchant)
      customer = Customer.create!(first_name: "Jerry", last_name: "Springer")
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      # item_3 on no invoices
      item_3 = create(:item, merchant_id: merchant.id)

      invoice_1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 'in progress')
      invoice_2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 'in progress')
      # invoice_3 contains no items and is not on an invoice_item
      invoice_3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 'in progress')

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price)
      invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 10, unit_price: item_1.unit_price)
      invoice_item_3 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 10, unit_price: item_2.unit_price)

      expect(Invoice.find_item_by_id(item_1.id)).to eq([invoice_1, invoice_2])
      expect(Invoice.find_item_by_id(item_2.id)).to eq([invoice_2])
      expect(Invoice.find_item_by_id(item_3.id)).to eq(nil)
    end
  end
end
