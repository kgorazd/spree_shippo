module Spree
  module Admin
    module OrdersHelper

		def shipment_label_url(shipment_id)
			record = Spree::Shipment.find(shipment_id)
			return record.label_url
		end

		def shipment_return_label_url(shipment_id)
	    	record = Spree::Shipment.find(shipment_id)
			return record.return_label_url 
		end
	end
  end	
end