
class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :merchant_id
  validates_presence_of :unit_price
  validates_numericality_of :unit_price

  def self.search_by_name(query)
    query = '%'.concat(query.downcase).concat('%')
    where('lower (name) like ?', query).order(:name)
  end

  def self.search_max_price(max_price)
    where('unit_price <= ?', max_price).order(:name)
  end

  def self.search_min_price(min_price)
    where('unit_price >= ?', min_price).order(:name)
  end
end
