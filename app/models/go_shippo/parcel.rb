class GoShippo::Parcel < ActiveRecord::Base
  include HTTParty

  def self.body(length,width, height, distance_unit, weight, mass_unit)
     "length=#{length}&width=#{width}&height=#{height}&distance_unit=#{distance_unit}&weight=#{weight}&mass_unit=#{mass_unit}"
  end

  def self.create(length,width, height, distance_unit, weight, mass_unit)
    HTTParty.post(base_path+base_url,
                  :body => self.body(length,width, height, distance_unit, weight, mass_unit),
                  :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )

  end

  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url
     "/parcels"
  end

end