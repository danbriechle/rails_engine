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

    found_customer_data = customer_data["data"]

    found_customer = found_customer_data["attributes"]

    expect(response).to be_successful

    expect(found_customer["last_name"]).to eq(customer.last_name)
  end

  it "can find all customers by last_name " do
    customer_1 = create(:customer, first_name: "joe", last_name: "schmoe")
    customer_2 = create(:customer, first_name: "dave", last_name: "schmoe")

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    customer_data= JSON.parse(response.body)

    found_customer_data = customer_data["data"]


    found_customer_1 = found_customer_data.first["attributes"]
    found_customer_2 = found_customer_data.last["attributes"]

    expect(response).to be_successful

    expect(found_customer_1["last_name"]).to eq(customer_2.last_name)
    expect(found_customer_2["last_name"]).to eq(customer_1.last_name)
    expect(found_customer_data.count).to eq(2)  
  end

  xit "can find a customer by its first_name " do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    customer_data= JSON.parse(response.body)

    found_customer_data = customer_data["data"]

    found_customer = found_customer_data["attributes"]

    expect(response).to be_successful

    expect(found_customer["first_name"]).to eq(customer.first_name)
  end



  xit "can find a customer by its created_at " do
    customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    customer_data= JSON.parse(response.body)

    found_customer = customer_data["data"]



    expect(response).to be_successful
    expect(found_customer["created_at"]).to eq(customer.created_at)
  end

  xit "can find a customer by its updated_at " do
    customer = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    customer_data= JSON.parse(response.body)

    found_customer = customer_data["data"]

    expect(response).to be_successful
    expect(found_customer["updated_at"]).to eq(customer.updated_at)
  end

end
