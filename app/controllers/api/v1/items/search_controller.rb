class Api::V1::Items::SearchController < ApplicationController

  def index
    if search_params.include?(:name) && !search_params[:name].empty?
      items = Item.search_by_name(search_params[:name])
      if items
        render json: ItemSerializer.new(items)
      end
    else
      render json: { data: { error: 'error', message: "No match found" } }, status: 400
    end
  end

  def show
    # Search for price range
    if search_params[:min_price].to_i > 0 && search_params[:max_price].to_i > 0 && search_params.keys.count == 2
      # Ensures min is less than max
      if search_params[:min_price].to_f < search_params[:max_price].to_f
        item = Item.search_price_range(search_params[:min_price].to_f, search_params[:max_price].to_f).first
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_data_error, status: 400
      end
    # Search min price
    elsif search_params[:min_price].to_i > 0 && search_params.keys.count == 1
      item = Item.search_min_price(search_params[:min_price].to_f).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_data_error, status: 400
      end
    # Search max price
    elsif search_params[:max_price].to_i > 0 && search_params.keys.count == 1
      item = Item.search_max_price(search_params[:max_price].to_f).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_data_error, status: 400
      end
    # Search name
    elsif search_params.include?(:name) && search_params[:name].empty? == false && search_params.keys.count == 1
      item = Item.search_by_name(search_params[:name]).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_data_error, status: 400
      end
    # Cannot search name and price
    else
      render json: ErrorSerializer.data_error_response, status: 400
    end
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
