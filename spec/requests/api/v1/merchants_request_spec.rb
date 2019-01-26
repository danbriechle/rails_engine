describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:item, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
  end
end
