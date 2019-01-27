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

  it "can find all transactions for the invoice" do
    invoice = create(:invoice)
    transaction_1 = create(:transaction, invoice_id: invoice.id)
    transaction_2 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    invoice_data= JSON.parse(response.body)

    found_transaction_data = invoice_data["data"]
    found_transaction_1 = found_transaction_data.first["attributes"]
    found_transaction_2 = found_transaction_data.last["attributes"]
    expect(response).to be_successful

    expect(found_transaction_2["invoice_id"]).to eq(invoice.id)
    expect(found_transaction_1["invoice_id"]).to eq(invoice.id)
  end

  it "can find all items for the invoice" do
    item_1 = create(:item)
    item_2 = create(:item)
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id,  item_id: item_2.id)


    get "/api/v1/invoices/#{invoice.id}/items"

    item_data = JSON.parse(response.body)

    found_item_data = item_data["data"]

    found_item_1 = found_item_data.first["attributes"]
    found_item_2 = found_item_data.last["attributes"]
    expect(response).to be_successful

    expect(found_item_2["description"]).to eq(item_2.description)
    expect(found_item_1["id"]).to eq(item_1.id)

  end

  it "can find all invoice_items for the invoice" do
    item_1 = create(:item)
    item_2 = create(:item)
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id,  item_id: item_2.id)


    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    item_invoice_data = JSON.parse(response.body)

    found_item_invoice_data = item_invoice_data["data"]

    found_item_invoice_1 = found_item_invoice_data.first["attributes"]
    found_item_invoice_2 = found_item_invoice_data.last["attributes"]
    expect(response).to be_successful

    expect(found_item_invoice_2["item_id"]).to eq(invoice_item_2.item_id)
    expect(found_item_invoice_1["id"]).to eq(invoice_item_1.id)

  end

  it "can find the customer for the invoice" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)


    get "/api/v1/invoices/#{invoice.id}/customer"

    customer_data = JSON.parse(response.body)

    found_customer_data = customer_data["data"]

    found_customer = found_customer_data["attributes"]
    expect(response).to be_successful

    expect(found_customer["last_name"]).to eq(customer.last_name)
    expect(found_customer["id"]).to eq(invoice.customer_id)

  end

  it "can find the merchant for the invoice" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    merchant_data = JSON.parse(response.body)

    found_merchant_data = merchant_data["data"]

    found_merchant = found_merchant_data["attributes"]
    expect(response).to be_successful

    expect(found_merchant["name"]).to eq(merchant.name)
    expect(found_merchant["id"]).to eq(invoice.merchant_id)
  end


end
