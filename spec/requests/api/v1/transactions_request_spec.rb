describe "transactions API" do
  it "sends a list of transactions" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    transaction = create(:transaction, invoice: invoice)

    item_2 = create(:item)
    customer_2 = create(:customer)
    merchant_2 = Merchant.find(item.merchant_id)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant )
    transaction_2 = create(:transaction, invoice: invoice)

    item_3 = create(:item)
    customer_3 = create(:customer)
    merchant_3 = Merchant.find(item.merchant_id)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant )
    transaction_3 = create(:transaction, invoice: invoice)

    get '/api/v1/transactions'

    expect(response).to be_successful
    transactions = JSON.parse(response.body)
  end

  it "can get one transaction by its id" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    id = create(:transaction, invoice: invoice).id


    get "/api/v1/transactions/#{id}"

    transaction_data= JSON.parse(response.body)

    transaction = transaction_data["data"]

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id.to_s)
  end

  it "can find a transaction by its invoice_id" do
    id = create(:invoice).id
    transaction = create(:transaction, invoice_id: id)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    transaction_data= JSON.parse(response.body)

    transaction_data = transaction_data["data"]
    transaction = transaction_data["attributes"]

    expect(response).to be_successful
    expect(transaction["invoice_id"]).to eq(id)
  end


  it "can find all transactions by invoice_id " do
    id = create(:invoice).id
    transaction_1 = create(:transaction, invoice_id: id)
    transaction_2 = create(:transaction, invoice_id: id)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"

    transaction_data = JSON.parse(response.body)


    found_transaction_data = transaction_data["data"]


    found_transaction_1 = found_transaction_data.first["attributes"]
    found_transaction_2 = found_transaction_data.last["attributes"]

    expect(response).to be_successful
    expect(found_transaction_data.count).to eq(2)
    expect(found_transaction_1["invoice_id"]).to eq(id)
    expect(found_transaction_2["invoice_id"]).to eq(id)
  end

  it "can find the invoice associated with the transaction" do
    id = create(:invoice).id
    transaction = create(:transaction, invoice_id: id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice_data = JSON.parse(response.body)


    found_invoice_data = invoice_data["data"]


    found_invoice = found_invoice_data["attributes"]

    expect(response).to be_successful
    expect(found_invoice["transaction_id"]).to eq(transaction.id)
    expect(found_invoice["invoice_id"]).to eq(id)


  end
end
