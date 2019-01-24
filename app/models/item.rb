class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description
  validates :unit_price, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }

  def best_day
    InvoiceItem.where(item_id: self.id)
    .order(:quantity)
    .last
    .created_at
  end
end
