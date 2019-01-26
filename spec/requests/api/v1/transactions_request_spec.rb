describe "transactions API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful
    transactions = JSON.parse(response.body)
  end
end
