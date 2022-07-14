require 'rails_helper'

RSpec.describe "Item Search Requests" do
  it "sends a single item from a name search" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Box fan", unit_price: 19.99)
    item_2 = create(:item, merchant_id: merchant.id, name: "Boxing gloves", unit_price: 39.99)
    item_3 = create(:item, merchant_id: merchant.id, name: "Wheelbarrow", unit_price: 59.99)
    item_4 = create(:item, merchant_id: merchant.id, name: "Candy bar", unit_price: 1.49)

    get '/api/v1/items/find?name=box'

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to be_a Hash

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a String

    expect(item).to have_key(:type)
    expect(item[:id]).to be_a String

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a Hash

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to eq('Box fan')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a String

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a Float

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a Integer
  end

  it "sends all items from a name search" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Box fan", unit_price: 19.99)
    item_2 = create(:item, merchant_id: merchant.id, name: "Boxing gloves", unit_price: 39.99)
    item_3 = create(:item, merchant_id: merchant.id, name: "Wheelbarrow", unit_price: 59.99)
    item_4 = create(:item, merchant_id: merchant.id, name: "Candy bar", unit_price: 1.49)

    get '/api/v1/items/find_all?name=box'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_a Array
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a String

      expect(item).to have_key(:type)
      expect(item[:id]).to be_a String

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a Hash

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a String

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a String

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end

  it "sends an error if name search fails" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Box fan", unit_price: 19.99)
    item_2 = create(:item, merchant_id: merchant.id, name: "Boxing gloves", unit_price: 39.99)
    item_3 = create(:item, merchant_id: merchant.id, name: "Wheelbarrow", unit_price: 59.99)
    item_4 = create(:item, merchant_id: merchant.id, name: "Candy bar", unit_price: 1.49)

    # Single search endpoints
    get '/api/v1/items/find'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name='
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name=boingo'
    expect(response.status).to eq(400)

    # All items search endpoints
    get '/api/v1/items/find_all'
    expect(response.status).to eq(400)

    get '/api/v1/items/find_all?name='
    expect(response.status).to eq(400)

    get '/api/v1/items/find_all?name=boingo'
    expect(response.status).to eq(200) # Returns empty Array
  end
end
