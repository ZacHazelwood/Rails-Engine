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
end
