describe "Customers API" do
  it "sends a list of customers" do
    create_list(:item, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)
  end

  it "can get one customer by its id" do
    id = create(:customer).id


    get "/api/v1/customer/#{id}"

    customer_data= JSON.parse(response.body)

    customer = customer_data["data"]

    expect(response).to be_successful
    expect(item["id"]).to eq(id.to_s)
  end
end
