class GoShippo::Shipment < ActiveRecord::Base
  include HTTParty

  def self.body(object_purpose, address_from, address_to, parcel, submission_type,submission_date,insurance_amount, insurance_currency, signature)
    s= {'object_purpose' => object_purpose,'address_from' => address_from,'address_to' => address_to,'parcel' => parcel,'submission_type' => submission_type,'submission_date' => submission_date,'insurance_amount' => insurance_amount,'insurance_currency' => insurance_currency,'async' => false}
      if signature == 'true' 
        s.merge!('extra' => {'signature_confirmation' => true})
      else
        s.merge!('extra' => {})  
      end
  end

  def self.create(object_purpose, address_from, address_to, parcel, submission_type,submission_date,insurance_amount, insurance_currency, signature)
    shipment_body = self.body(object_purpose, address_from, address_to, parcel, submission_type,submission_date, insurance_amount, insurance_currency, signature)
    HTTParty.post(base_path+base_url,
                  :body => shipment_body.to_json,
                  :headers => { 'Content-Type' => 'application/json' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )
  
  end

  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url
     "/shipments"
  end

end
