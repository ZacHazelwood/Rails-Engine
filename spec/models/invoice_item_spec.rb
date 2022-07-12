require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_one(:merchant).through(:invoice) }
    it { should have_one(:customer).through(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
  end
end
