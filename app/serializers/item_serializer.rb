class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :merchant_id, :description

  attribute :unit_price do |object|
   (object.unit_price.to_i.to_f / 100).to_s
  end

end
