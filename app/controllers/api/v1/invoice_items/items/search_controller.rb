class Api::V1::InvoiceItems::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find(InvoiceItem.find(params[:invoice_item_id]).item_id))
  end

end
