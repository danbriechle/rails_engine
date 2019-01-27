class Api::V1::Invoices::Customer::SearchController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.find(Invoice.find(params[:invoice_id]).customer_id))
  end

end
