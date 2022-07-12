require 'rails_helper'

RSpec.describe 'Items API requests' do
  it "gets a list of all items" do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_a Array
    expect(items.count).to eq 5

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

  it "gets a single item from request" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

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
    expect(item[:attributes][:name]).to be_a String

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a String

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a Float

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a Integer
  end

  it "sends an error if item not found" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, id: 1)

    get "/api/v1/items/2"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response.code).to eq("404")
    expect(response.message).to eq("Not Found")
    expect(response_body[:message]).to eq("Item not found")
  end

  it "creates an item" do
    merchant = create(:merchant)
    item_params = { name: "Box fan",
                    description: "It's not actually a box.",
                    unit_price: 19.99,
                    merchant_id: merchant.id
                  }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON(item_params)

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
    expect(item[:attributes][:name]).to be_a String

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a String

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a Float

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a Integer
  end
end
