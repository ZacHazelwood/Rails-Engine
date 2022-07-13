class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant.search_by_name(search_params[:name])
    render json: MerchantSerializer.new(merchants), status: 200
  end

  def show
    merchant = Merchant.search_by_name(search_params[:name]).first
    render json: MerchantSerializer.new(merchant), status: 200
  end

  private
    def search_params
      params.permit(:name)
    end
end
