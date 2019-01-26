describe "Invoice_items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
  end

  it "can get one invoice by its id" do
    id = create(:customer).id


    get "/api/v1/invoices/#{id}"

    invoice_data= JSON.parse(response.body)

    invoice = invoice_data["data"]

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id.to_s)
  end
end
