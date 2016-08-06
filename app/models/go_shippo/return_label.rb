class GoShippo::ReturnLabel < ActiveRecord::Base
  include HTTParty

  def self.body(object_purpose, address_from, address_to, parcel, submission_type, return_of,submission_date,insurance_amount, insurance_currency)
     "object_purpose=#{object_purpose}&address_from=#{address_from}&address_to=#{address_to}&parcel=#{parcel}&submission_type=#{submission_type}&return_of=#{return_of}&submission_date=#{submission_date}&insurance_amount=#{insurance_amount}&insurance_currency=#{insurance_currency}&async=false"
  end

  def self.create(object_purpose, address_from, address_to, parcel, submission_type, return_of,submission_date,insurance_amount, insurance_currency)
    HTTParty.post(base_path+base_url,
                  :body => self.body(object_purpose, address_from, address_to, parcel, submission_type,return_of,submission_date, insurance_amount, insurance_currency),
                  :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )

  end

  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url
     "/shipments"
  end
end