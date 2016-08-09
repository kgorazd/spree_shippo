module Spree
	Order.class_eval do
		def summary_state
			if self.payment_state.to_s != "paid"
				state = (self.payment_state.to_s).titleize
            elsif self.payment_state.to_s == "paid" && Spree::Order.checkout_step_names.include?(:delivery)
            	state = "Shipped"
            	for shipment in self.shipments
            		if shipment.state.to_s != "shipped"
            			state = "Paid and Ready to Ship"
            			break
            		end
            	end
            	# if self.shipment_state.to_s != "shipped"
             #    	state = "Paid and Ready to Ship"
             #    elsif self.shipment_state.to_s == "shipped"
             #    	state = "Shipped"
             #    end
            end
			return state
		end
	end
end