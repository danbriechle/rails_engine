class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_one :invoice_item
  has_many :items
  has_many :transactions

  validates_presence_of :status
end
