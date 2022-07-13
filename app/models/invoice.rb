
class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates_presence_of :customer_id
  validates_presence_of :merchant_id
  validates_presence_of :status

  def self.find_item_by_id(item_id)
    joins(:invoice_items).where('invoice_items.item_id = ?', item_id)
  end
end
