class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def best_day
    InvoiceItem.where(item_id: self.id)
    .order(:quantity)
    .last
    .created_at
  end
end
