class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find_by_id(params[:merchant_id])
    if merchant
      render json: ItemSerializer.new(merchant.items)
    else
      render json: { error: "Not Found" }, status: 404
    end
  end
end
