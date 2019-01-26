describe "Invoice_items API" do
  it "sends a list of invoice_items" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    invoice_item = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    item_2 = create(:item)
    customer_2 = create(:customer)
    merchant_2 = Merchant.find(item.merchant_id)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant )
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    item_3 = create(:item)
    customer_3 = create(:customer)
    merchant_3 = Merchant.find(item.merchant_id)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant )
    invoice_item_3 = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
  end

  it "can get one invoice_item by its id" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    invoice_item = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    id = invoice_item.id


    get "/api/v1/invoice_items/#{id}"

    invoice_data= JSON.parse(response.body)

    invoice = invoice_data["data"]

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id.to_s)
  end
end
