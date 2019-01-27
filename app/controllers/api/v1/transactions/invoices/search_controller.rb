class Api::V1::Transactions::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find(Transaction.find(params["transaction_id"]).invoice_id))
  end
end
