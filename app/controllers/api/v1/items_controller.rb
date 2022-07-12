class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = Item.find_by_id(params[:id])
    if item
      render json: ItemSerializer.new(item)
    else
      render json: { status: "Not Found", code: 404, message: 'Item not found' }, status: 404
    end
  end
end
