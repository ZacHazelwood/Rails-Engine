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

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(item).to be_a Hash

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a String

    expect(item).to have_key(:type)
    expect(item[:id]).to be_a String

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a Hash

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a String
    expect(item[:attributes][:name]).to eq("Box fan")

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a String
    expect(item[:attributes][:description]).to eq("It's not actually a box.")

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a Float
    expect(item[:attributes][:unit_price]).to eq(19.99)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a Integer
    expect(item[:attributes][:merchant_id]).to eq(merchant.id)
  end

  it "updates an item request" do
    merchant_1 = create(:merchant)
    item_params = { name: "Box fan",
                    description: "It's not actually a box.",
                    unit_price: 19.99,
                    merchant_id: merchant_1.id
                  }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    merchant_2 = create(:merchant)
    item = Item.last

    update_item_params = { name: "Box fan",
                    description: "Okay, it's kind of a box.",
                    unit_price: 19.99,
                    merchant_id: merchant_2.id
                  } # Updating description and merchant_id
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: update_item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
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
    expect(item[:attributes][:merchant_id]).to eq(merchant_2.id)
    expect(item[:attributes][:merchant_id]).to_not eq(merchant_1.id)
  end

  it "responds 404 if merchant or item is not found when updating an item" do
    merchant = create(:merchant, id: 2)
    item = create(:item, merchant_id: merchant.id, id: 2)

    get "/api/v1/items/3"

    expect(response.status).to eq(404)
    expect(response.code).to eq("404")
    expect(response.message).to eq("Not Found")

    update_item_params = { name: "Box fan",
                    description: "Okay, it's kind of a box.",
                    unit_price: 19.99,
                    merchant_id: 1
                  } # wrong merchant
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: update_item_params)

    expect(response.status).to eq(404)
    expect(response.code).to eq("404")
    expect(response.message).to eq("Not Found")
  end

  it "sends a request to destroy an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq(204)
    expect(response.body).to eq("")
  end
end
