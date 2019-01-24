require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :description }
  end

  describe 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
  end
  describe 'instance methods' do
    it '.best_day' do
      item = create(:item)
      customer = create(:customer)
      merchant = Merchant.find(item.merchant_id)
      invoice = create(:invoice, customer: customer, merchant: merchant )
      create(:invoice_item, invoice: invoice, item: item, quantity: 40)

      create(:invoice, customer: customer, merchant: merchant )
      invoice_item_2 = create(:invoice_item, invoice: invoice, item: item, created_at: 3.days.ago, quantity: 300)

      day = item.best_day

      expect(day).to eq(invoice_item_2.created_at)
    end
  end
end
