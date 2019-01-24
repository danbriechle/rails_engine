require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'instance methods' do
    it '.best_day' do
      item = create(:item)
      customer = create(:customer)
      merchant = Merchant.find(item.merchant_id)
      invoice = create(:invoice, customer: customer, merchant: merchant )
      invoice_item = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

      invoice_2 = create(:invoice, customer: customer, merchant: merchant )
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item, created_at: 3.days.ago, quantity: 300)

      day = item.best_day

      expect(day).to eq(invoice_item_2.created_at)
    end
  end
end
