class Api::V1::Items::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(Item.find(params["item_id"]).merchant_id))
  end
end
