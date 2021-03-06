class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :item_id, :quantity

  attribute :unit_price do |object|
    (object.unit_price.to_i / 100.00).to_s
  end

end
