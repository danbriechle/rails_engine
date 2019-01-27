describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

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

  it "can find a merchant by its id " do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    merchant_data = JSON.parse(response.body)

    found_merchant = merchant_data["data"]

    expect(response).to be_successful
    expect(found_merchant["id"]).to eq(merchant.id.to_s)
  end

  it "can find all merchants by name " do
    merchant_1 = create(:merchant, name: "dave")
    merchant_2 = create(:merchant, name: "dave")


    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    merchant_data = JSON.parse(response.body)

    found_merchant_data = merchant_data["data"]
    found_merchant_1 = found_merchant_data.first["attributes"]
    found_merchant_2 = found_merchant_data.last["attributes"]



    expect(response).to be_successful
    expect(found_merchant_1["name"]).to eq(merchant_2.name)
    expect(found_merchant_2["name"]).to eq(merchant_1.name)
    expect(found_merchant_data.count).to eq(2)
  end

  it " can find all the items associated with one merchant " do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    item_data = JSON.parse(response.body)

    found_item_data = item_data["data"]

    found_item_1 = found_item_data.first["attributes"]
    found_item_2 = found_item_data.last["attributes"]
    expect(response).to be_successful

    expect(found_item_2["description"]).to eq(item_2.description)
    expect(found_item_1["id"]).to eq(item_1.id)
  end

  it " can find all the invoices associated with one merchant " do
    merchant = create(:merchant)
    invoice_1 = create(:item, merchant_id: merchant.id)
    invoice_2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoice_data = JSON.parse(response.body)

    found_invoice_data = invoice_data["data"]

    found_invoice_1 = found_invoice_data.first["attributes"]
    found_invoice_2 = found_invoice_data.last["attributes"]
    expect(response).to be_successful

    expect(found_invoice_2["status"]).to eq(invoice_2.status)
    expect(found_invoice_1["id"]).to eq(invoice_1.id)
  end
end
