class GoShippo::Address < ActiveRecord::Base
  include HTTParty

  def self.body(name,object_purpose,company, street1, street2, city,state,zip,country,phone,email, is_residential)
     "name=#{name}&object_purpose=#{object_purpose}&street1=#{street1}&street2=#{street2}&city=#{city}&state=#{state}&zip=#{zip}&country=#{country}&phone=#{phone}&email=#{email}&is_residential=#{is_residential}"
  end

  def self.create(name,object_purpose,company, street1, street2, city,state,zip,country,phone,email, is_residential)
    HTTParty.post(base_path+base_url,
                  :body => self.body(name,object_purpose,company, street1, street2, city,state,zip,country,phone,email, is_residential),
                  :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )
  end

  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url
     "/addresses"
  end
end
