class Api::V1::ItemMerchantController < ApplicationController

  def index
    item = Item.find_by_id(params[:item_id])
    if item
      render json: MerchantSerializer.new(item.merchant)
    else
      render json: { status: "Not Found", code: 404 }, status: 404
    end
  end
end
