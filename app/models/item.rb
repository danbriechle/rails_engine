class Item < ApplicationRecord
  attr_reader :best_day

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description
  validates :unit_price, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }

  def best_day
    Invoice.joins(:invoice_items)
     .select("invoices.*")
     .where('invoice_items.item_id = ?', self.id)
     .order("invoice_items.quantity desc")
     .first
     .created_at
  end
end
