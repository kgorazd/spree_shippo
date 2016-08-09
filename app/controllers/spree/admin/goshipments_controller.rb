class Spree::Admin::GoshipmentsController < Spree::Admin::BaseController
 
  #creates a GoShippo parcel by providing the necessary details     
  def create_parcel
      begin
        
        shipping_label = PackageType.find(params[:spree_shipping_label_id])
        shippo_parcel = shipping_label.create_shippo_parcel(params[:weight], params[:mass_unit])
        shipment = Spree::Shipment.find(params[:shipment_id])
        order = Spree::Order.find(shipment.order_id)
       
        #update the parcel object inside the shipment
        shipment.update_attributes(parcel_object_id: shippo_parcel['object_id'])
       
        #get the parcel id to be passed for creating the shipment
        parcel = shippo_parcel['object_id']
      
        #proceed with shipment creation if the order has been approved
        if order.approved?
          stop_address = order.ship_address
          start_address = order.line_items.last.variant.stock_locations.last
          address_to = stop_address.create_shippo_address('PURCHASE', params[:Residential_recipient], order.email)
          address_from = start_address.create_shippo_address('PURCHASE', params[:Residential_recipient], order.email)
          
          submition_date = (params['shipment_date'].to_time).utc.iso8601
          go_shippo_shipment = GoShippo::Shipment.create('PURCHASE', address_from, address_to, parcel, 'DROPOFF', submition_date, params[:insurance_amount], params[:insurance_currency], params[:Add_signature_confirmation])
          shipment.update_attributes(shipment_obj_id: go_shippo_shipment['object_id'])
          @goshippo_ratelist = GoShippo::Rate.get(go_shippo_shipment['object_id'])
          if @goshippo_ratelist['count'] == 0
            redirect_to :back, flash: { error: 'Invalid Order Details' }
          end
        end
        rescue Exception => e
        redirect_to :back, flash: { error: "Something went Wrong. Please Try Again. " }
      end
  end
  
  
  def transactions
    begin
      transaction_object = GoShippo::Transaction.create(params['object_id'])
      shipment = Spree::Shipment.find(params[:shipment_id])
      
      @order = Spree::Order.find(shipment.order_id)
      
      shipment.update_attributes(transaction_obj_id: transaction_object['object_id'])
      @transactions_ship = transaction_object
      if @transactions_ship['messages'].present?
        redirect_to admin_orders_path, notice: @transactions_ship['messages'][0]['text']
      else
        shipment.update_attributes(tracking: @transactions_ship['tracking_url_provider'])
        shipment.update_attributes(label_url: @transactions_ship['label_url'])
      end  
    rescue Exception => e
      redirect_to :back, flash: { error: 'Something went Wrong. Please Try Again' }      
    end
  end
  
  
  def return_label
  
    
    shipping_label = PackageType.find(params[:spree_shipping_label_id])
    shippo_parcel = shipping_label.create_shippo_parcel(params[:weight], params[:mass_unit])
    shipment = Spree::Shipment.find(params[:shipment_id])
    order = Spree::Order.find(shipment.order_id)
   
    shipment.update_attributes(parcel_object_id: shippo_parcel['object_id'])
    parcel = shippo_parcel['object_id']
    
    stop_address = order.ship_address
    start_address = order.line_items.last.variant.stock_locations.last
   
    #interchange of the addresses done inside the model itself, not here 
    address_to = stop_address.create_shippo_address('PURCHASE', params[:Residential_recipient], order.email)
    address_from = start_address.create_shippo_address('PURCHASE', params[:Residential_recipient], order.email)
    
    return_of = shipment['transaction_obj_id']
    submition_date = (params['shipment_date'].to_time).utc.iso8601
    go_shippo_return_shipment = GoShippo::ReturnLabel.create('PURCHASE', address_from, address_to, parcel, 'PICKUP', return_of, submition_date, params[:insurance_amount], params[:insurance_currency])
    shipment.update_attributes(return_shipment_obj_id: go_shippo_return_shipment['object_id'])
    @goshippo_ratelist = GoShippo::Rate.get(go_shippo_return_shipment['object_id'])
    if @goshippo_ratelist['count'] == 0
      redirect_to :back, flash: { error: 'Invalid Order Details' }
    end
  
  end


  def return_transactions
    begin
      transaction_object = GoShippo::Transaction.create(params['object_id'])
      shipment = Spree::Shipment.find(params[:shipment_id])
        
      shipment.update_attributes(transaction_obj_id: transaction_object['object_id'])
      @transactions_ship = transaction_object
      if @transactions_ship['messages'].present?
        redirect_to admin_orders_path, notice: @transactions_ship['messages'][0]['text']
      else
        shipment.update_attributes(return_label_url: @transactions_ship['label_url'])
      end  
    rescue Exception => e
      redirect_to :back, flash: { error: 'SomeThing went Wrong. Please Try Again' }      
    end
  end


end  