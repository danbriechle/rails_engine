class Api::V1::InvoiceItems::Invoices::SearchController < ApplicationController

  def show
   render json: InvoiceSerializer.new(Invoice.find(InvoiceItem.find(params[:invoice_item_id]).invoice_id))
  end

end
