class Api::V1::Invoices::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: params[:invoice_id]))
    # move method to model
  end

end
