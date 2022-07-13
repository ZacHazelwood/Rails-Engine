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

  def update
    item_update = Item.find_by_id(params[:id])
    merchant = Merchant.find_by_id(item_params[:merchant_id])
    if item_update && merchant || item_update && !item_params.include?(:merchant_id)
      item_update.update(item_params)
      item_update.save
      render json: ItemSerializer.new(item_update), status: 200
    else
      render json: { status: "Not Found", code: 404 }, status: 404
    end
  end

  def destroy
    item = Item.find_by_id(params[:id])
    invoices = Invoice.find_item_by_id(item.id)
    invoices.each do |invoice|
      if invoice.items.count == 1
        invoice.destroy
      end
    end
    item.destroy  
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
