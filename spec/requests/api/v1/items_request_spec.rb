describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)
  end

  it "can get one item by its id" do
    id = create(:item).id


    get "/api/v1/items/#{id}"

    item_data= JSON.parse(response.body)

    item = item_data["data"]

    expect(response).to be_successful
    expect(item["id"]).to eq(id.to_s)
  end

  it "can find an item by its id " do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    item_data = JSON.parse(response.body)

    found_item = item_data["data"]

    expect(response).to be_successful
    expect(found_item["id"]).to eq(item.id.to_s)
  end

  it "can find all items by its merchant_id " do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

    item_data = JSON.parse(response.body)

    found_item_data = item_data["data"]
    found_item_1 = found_item_data.first["attributes"]
    found_item_2 = found_item_data.last["attributes"]



    expect(response).to be_successful
    expect(found_item_1["merchant_id"]).to eq(item_2.merchant_id)
    expect(found_item_2["merchant_id"]).to eq(item_1.merchant_id)
    expect(found_item_data.count).to eq(2)
  end

  it " can find all items by its unit_price " do

    item_1 = create(:item, unit_price: "1251")
    item_2 = create(:item, unit_price: "1251")

    get "/api/v1/items/find_all?unit_price=12.51"

    item_data = JSON.parse(response.body)

    found_item_data = item_data["data"]
    found_item_1 = found_item_data.first["attributes"]
    found_item_2 = found_item_data.last["attributes"]



    expect(response).to be_successful
    expect(found_item_1["unit_price"]).to eq("12.51")
    expect(found_item_2["unit_price"]).to eq("12.51")
    expect(found_item_data.count).to eq(2)
  end

  it " can find all invoice_items associated with the item " do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, item_id: item.id)
    invoice_item_2 = create(:invoice_item, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_item_data = JSON.parse(response.body)

    found_invoice_item_data = invoice_item_data["data"]

    found_invoice_item_1 = found_invoice_item_data.first["attributes"]
    found_invoice_item_2 = found_invoice_item_data.last["attributes"]

    expect(response).to be_successful
    expect(found_invoice_item_data.count).to eq(2)
    expect(found_invoice_item_1["item_id"]).to eq(invoice_item_1.item_id)
    expect(found_invoice_item_2["item_id"]).to eq(item.id)

  end


  xit "can find the best day of an item" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    create(:invoice, customer: customer, merchant: merchant )
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item, created_at: 3.days.ago, quantity: 300)

    get "/api/v1/items/#{item.id}/best_day"
    day = JSON.parse(response.body)
    expect(response).to be_successful
    expect(day).to eq(invoice_item_2.created_at)
  end

end
