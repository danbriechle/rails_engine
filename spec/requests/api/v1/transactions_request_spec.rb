describe "transactions API" do
  it "sends a list of items" do
    create_list(:item, 3)

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
