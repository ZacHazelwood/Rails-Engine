class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :invoice
  has_one :customer, through: :invoice

  validates_presence_of :item_id
  validates_presence_of :invoice_id
end
