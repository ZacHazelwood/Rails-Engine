class Api::V1::Merchants::SearchController < ApplicationController

  def index
    if search_params.include?(:name) && !search_params[:name].empty?
      merchants = Merchant.search_by_name(search_params[:name])
      if merchants
        render json: MerchantSerializer.new(merchants)
      # else
      #   render json: { data: { message: "No match found" } }, status: 400
      end
    else
      render json: { data: { message: "No match found" } }, status: 400
    end
  end

  def show
    if search_params.include?(:name) && !search_params[:name].empty?
      merchant = Merchant.search_by_name(search_params[:name]).first
      if merchant
        render json: MerchantSerializer.new(merchant)
      else
        render json: { data: { message: "No match found" } }, status: 400
      end
    else
      render json: { data: { message: "No match found" } }, status: 400
    end
  end

  private
    def search_params
      params.permit(:name)
    end
end
