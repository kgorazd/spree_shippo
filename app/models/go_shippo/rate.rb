class GoShippo::Rate < ActiveRecord::Base
  include HTTParty

  def self.get(shipment_obj,currency="USD")
    HTTParty.get(base_path+base_url(shipment_obj,currency),
              :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )

  end

  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url(shipment_obj,currency)
     "/shipments/#{shipment_obj}/rates/#{currency}"
  end

end