require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'relationships' do
    it { should have_many :invoices}
  end

  describe 'instance methods' do
    it 'favorite_merchant' do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)

      invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
      invoice_5 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)

      expect(customer.favorite_merchant).to eq([merchant_1])
      expect(customer.favorite_merchant).to_not eq([merchant_2])
    end
  end
end
