class Api::V1::Customers::Invoices::SearchController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where(customer_id: params["customer_id"]))
  end
end
