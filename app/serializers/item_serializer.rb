class ItemSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :merchant

  attributes :id, :name, :merchant_id, :description, :unit_price

end
