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

  it "can find an invoice_item by its invoice_id " do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]

    found_invoice_item = found_invoice_item_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item["invoice_id"]).to eq(invoice_item.invoice_id)
  end

  it "can find all invoice_items by invoice_id " do
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]


    found_invoice_item_1 = found_invoice_item_data.first["attributes"]
    found_invoice_item_2 = found_invoice_item_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item_data.count).to eq(2)
    expect(found_invoice_item_1["invoice_id"]).to eq(invoice_item_1.invoice_id)
    expect(found_invoice_item_2["invoice_id"]).to eq(invoice_item_2.invoice_id)
  end

  it "can find an invoice_item by its item_id " do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]

    found_invoice_item = found_invoice_item_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item["item_id"]).to eq(invoice_item.item_id)
  end

  it "can find all invoice_items by item_id " do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, item_id: item.id)
    invoice_item_2 = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]


    found_invoice_item_1 = found_invoice_item_data.first["attributes"]
    found_invoice_item_2 = found_invoice_item_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item_data.count).to eq(2)
    expect(found_invoice_item_1["item_id"]).to eq(invoice_item_1.item_id)
    expect(found_invoice_item_2["item_id"]).to eq(invoice_item_2.item_id)
  end

  it "can find an invoice_item by its quantity " do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]

    found_invoice_item = found_invoice_item_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item["quantity"]).to eq(invoice_item.quantity)
  end

  it "can find all invoice_items by quantity " do
    invoice_item_1 = create(:invoice_item, quantity: 40)
    invoice_item_2 = create(:invoice_item, quantity: 40)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]


    found_invoice_item_1 = found_invoice_item_data.first["attributes"]
    found_invoice_item_2 = found_invoice_item_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item_data.count).to eq(2)
    expect(found_invoice_item_1["quantity"]).to eq(invoice_item_1.quantity)
    expect(found_invoice_item_2["quantity"]).to eq(invoice_item_2.quantity)
  end

  it "can find an invoice_item by its unit price " do
    invoice_item = create(:invoice_item, unit_price: "1200.56")

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]

    found_invoice_item = found_invoice_item_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item["unit_price"]).to eq(invoice_item.unit_price)
  end

  it "can find all invoice_items by unit_price " do
    invoice_item_1 = create(:invoice_item, unit_price: 1200)
    invoice_item_2 = create(:invoice_item, unit_price: 1200)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]


    found_invoice_item_1 = found_invoice_item_data.first["attributes"]
    found_invoice_item_2 = found_invoice_item_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item_data.count).to eq(2)
    expect(found_invoice_item_1["unit_price"]).to eq(invoice_item_1.unit_price)
    expect(found_invoice_item_2["unit_price"]).to eq(invoice_item_2.unit_price)
  end

end
