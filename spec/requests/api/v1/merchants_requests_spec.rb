require 'rails_helper'

RSpec.describe 'Merchants API requests' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants).to be_a Array
    expect(merchants.count).to be 5

    merchants.each do |merchant|
      expect(merchant).to be_a Hash
      expect(merchant).to have_key (:id)
      expect(merchant[:id]).to be_a String

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a String
      expect(merchant[:type]).to eq("merchant")

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it 'sends just one merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful
    expect(merchant).to have_key (:id)
    expect(merchant[:id]).to be_a String

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a String
    expect(merchant[:type]).to eq("merchant")

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a String
  end

  it "sends an error if a merchant is not found" do
    merchant = create(:merchant, id: 5)

    get "/api/v1/merchants/6"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response.code).to eq("404")
    expect(response.message).to eq("Not Found")
    expect(response_body[:message]).to eq("Merchant not found")
  end

  it "sends a list of items belonging to a merchant" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_a Array
    expect(items.count).to eq 3

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a String

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a String
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)

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

  it "sends an error if a merchant is not found, items" do
    merchant = create(:merchant, id: 5)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/6/items"

    expect(response.status).to eq(404)
  end
end
