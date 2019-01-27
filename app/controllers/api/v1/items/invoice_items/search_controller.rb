class Api::V1::Items::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: params["item_id"]))
  end
end
