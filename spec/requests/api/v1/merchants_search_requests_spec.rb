require 'rails_helper'

RSpec.describe 'Merchant Search Requests' do
  it "sends a single Merchant from a query" do
    merchant_1 = create(:merchant, name: "Turing")
    merchant_2 = create(:merchant, name: "Ring World")
    merchant_3 = create(:merchant, name: "Ring LLC")
    merchant_4 = create(:merchant, name: "Walgreens")

    get '/api/v1/merchants/find?name=ring'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response.status).to eq(200)
    expect(merchant).to be_a Hash
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a String

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq('merchant')

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq('Ring LLC')
  end

  it "sends all merchants from a query" do
    merchant_1 = create(:merchant, name: "Turing")
    merchant_2 = create(:merchant, name: "Ring World")
    merchant_3 = create(:merchant, name: "Ring LLC")
    merchant_4 = create(:merchant, name: "Walgreens")

    get '/api/v1/merchants/find_all?name=ring'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response.status).to eq(200)
    expect(merchants).to be_a(Array)
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a String

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a String

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it "sends errors if query not assigned or no object exists" do
    merchant_1 = create(:merchant, name: 'Turing')
    merchant_2 = create(:merchant, name: 'Ring World')
    merchant_3 = create(:merchant, name: 'Ring LLC')
    merchant_4 = create(:merchant, name: "Walgreens")

    get '/api/v1/merchants/find'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find?name='
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find?name=nintendo'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find_all'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find_all?name='
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find_all?name=nintendo'
    expect(response.status).to eq(200) # Returns an empty Array
  end
end
