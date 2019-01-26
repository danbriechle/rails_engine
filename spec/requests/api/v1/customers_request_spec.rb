describe "Customers API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)
  end
end
