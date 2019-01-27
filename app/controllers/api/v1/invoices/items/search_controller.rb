class Api::V1::Invoices::Items::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.find(InvoiceItem.where(invoice_id: params[:invoice_id]).pluck(:item_id)))
    # move method to model
  end

end
