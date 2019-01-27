class Api::V1::Customers::FavoriteMerchant::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Customer.find(params["customer_id"]).favorite_merchant)
  end
end
