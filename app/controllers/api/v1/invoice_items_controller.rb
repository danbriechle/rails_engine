class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end
end
