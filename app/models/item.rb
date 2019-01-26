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
    Item.joins(:invoice_item)
    # .select('invoice.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as best_day' )
    # .order('best_day')
    # .first
  end
end
