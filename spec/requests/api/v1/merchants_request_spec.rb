describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:item, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id


    get "/api/v1/merchants/#{id}"

    merchant_data= JSON.parse(response.body)

    merchant = merchant_data["data"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id.to_s)
  end
end
