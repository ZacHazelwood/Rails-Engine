class Api::V1::Items::SearchController < ApplicationController

  def index

  end

  def show
    if search_params.include?(:name) && !search_params[:name].empty?
      item = Item.search_by_name(search_params[:name]).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: { data: { message: "No match found" } }, status: 400
      end
    else
      render json: { data: { message: "No match found" } }, status: 400
    end
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
