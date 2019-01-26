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
end
