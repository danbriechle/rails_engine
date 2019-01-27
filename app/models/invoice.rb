class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_one :invoice_item
  

  validates_presence_of :status
end
