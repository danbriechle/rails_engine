describe "Invoice_items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
  end
end
