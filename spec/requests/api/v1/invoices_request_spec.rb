describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:item, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
  end

  it "can get one invoice by its id" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )

    id = invoice.id


    get "/api/v1/invoices/#{id}"

    invoice_data= JSON.parse(response.body)

    invoice = invoice_data["data"]

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id.to_s)
  end
end
