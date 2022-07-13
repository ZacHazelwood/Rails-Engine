class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.search_by_name(query)
    query = '%'.concat(query.downcase).concat('%')
    where('lower (name) like ?', query).order(:name)
  end
end
