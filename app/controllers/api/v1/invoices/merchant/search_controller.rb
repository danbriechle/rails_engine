class Api::V1::Invoices::Merchant::SearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find(Invoice.find(params[:invoice_id]).merchant_id))
  end

end
