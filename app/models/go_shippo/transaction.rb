class GoShippo::Transaction < ActiveRecord::Base
  include HTTParty

  def self.body(rate)
     "rate=#{rate}&async=false"
  end

  def self.create(rate)
    HTTParty.post(base_path+base_url,
                  :body => self.body(rate),
                  :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' , 'Authorization' => "ShippoToken #{Spree::Store.first.goshippo_api}"} )
  end
  
  private

  def self.base_path
    Spree::Store.first.goshippo_base_api_url
  end
  def self.base_url
     "/transactions"
  end

end