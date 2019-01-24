describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can find an item by its id " do
    id = create(:item).id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can find the best day of an item" do
    item = create(:item)
    customer = create(:customer)
    merchant = Merchant.find(item.merchant_id)
    invoice = create(:invoice, customer: customer, merchant: merchant )
    invoice_item = create(:invoice_item, invoice: invoice, item: item, quantity: 40)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant )
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item, created_at: 3.days.ago, quantity: 300)

    get "/api/v1/items/#{item.id}/best_day"
    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item).to eq(invoice_item_2.created_at)

  end

end
