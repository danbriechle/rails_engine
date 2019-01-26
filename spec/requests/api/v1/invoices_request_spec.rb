describe "Invoices API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
  end
end
