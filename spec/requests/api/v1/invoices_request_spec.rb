describe "Invoices API" do
  it "sends a list of invoices" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )

    item_2 = create(:item)
    customer_2 = create(:customer)
    merchant_2 = Merchant.find(item.merchant_id)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant )

    item_3 = create(:item)
    customer_3 = create(:customer)
    merchant_3 = Merchant.find(item.merchant_id)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant )

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

  it "can find an invoice by its id " do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    invoice_data = JSON.parse(response.body)

    found_invoice_data = invoice_data["data"]

    found_invoice = found_invoice_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice["id"]).to eq(invoice.id)
  end

  it "can find all invoices by merchant_id " do
    merchant = create(:merchant)
    invoice_1 = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)


    get "/api/v1/invoices/find_all?merchant_id=#{invoice_1.merchant_id}"

    invoice_data = JSON.parse(response.body)

    found_invoice_data = invoice_data["data"]

    found_invoice_1 = found_invoice_data.first["attributes"]
    found_invoice_2 = found_invoice_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_data.count).to eq(2)
    expect(found_invoice_1["merchant_id"]).to eq(invoice_1.merchant_id)
    expect(found_invoice_2["merchant_id"]).to eq(invoice_2.merchant_id)
  end
end
