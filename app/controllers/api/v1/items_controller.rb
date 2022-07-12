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

  def create
    item_create = Item.create(item_params)
    render json: ItemSerializer.new(item_create), status: 201
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end
