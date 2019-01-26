describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)
  end

  it "can get one customer by its id" do
    id = create(:customer).id


    get "/api/v1/customers/#{id}"

    customer_data= JSON.parse(response.body)

    customer = customer_data["data"]

    expect(response).to be_successful
    expect(customer["id"]).to eq(id.to_s)
  end

  it "can find a customer by its id " do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    customer_data= JSON.parse(response.body)

    found_customer = customer_data["data"]

    expect(response).to be_successful
    expect(found_customer["id"]).to eq(customer.id.to_s)
  end

  it "can find a customer by its last_name " do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    customer_data= JSON.parse(response.body)

    found_customer = customer_data["data"]

    expect(response).to be_successful
    expect(found_customer["id"]).to eq(customer.id.to_s)
  end

end
