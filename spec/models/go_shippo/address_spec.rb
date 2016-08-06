require 'spec_helper'

describe GoShippo::Address do
    
     class DummyClass
     end

      let!(:store) { FactoryGirl.create(:store) }
      let!(:ship_address) { FactoryGirl.create(:ship_address) }

      before(:all) do
          @dummy = DummyClass.new
          @dummy.extend SpreeShippoLabels
      end

    
      it "create a valid GoShippo Address object" do
		address_obj=GoShippo::Address.create('John Doe','PURCHASE', 'Company', '10 Lovely Street', 'Northwest', 'Herndon','VA','35005', '232','555-555-0199','anoopkanyan@gmail.com', true)
        expect(address_obj).not_to be_nil 
      end
end    



    