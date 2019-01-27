class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  validates_presence_of :first_name, :last_name

  def favorite_merchant
    Merchant.joins(:invoices)
            .select("merchants.*, count(invoices.id) as total_purchases")
            .where('invoices.customer_id = ?', self.id)
            .where('invoices.status = ?', "Shipped")
            .group("merchants.id")
            .order("total_purchases desc")
            .limit(1)
  end

end
