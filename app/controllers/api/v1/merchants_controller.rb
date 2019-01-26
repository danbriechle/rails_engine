class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Item.all)
  end
end
