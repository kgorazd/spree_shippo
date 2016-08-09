require 'spec_helper'


describe PackageType do
    
    
      let!(:store) { FactoryGirl.create(:store) }
      let!(:user) { FactoryGirl.create(:user) }

      
      it "creates a valid GoShippo Parcel object" do
        parcel = GoShippo::Parcel.create('15.81','10.19','12.94','in','2','kg')
        expect(parcel[:object_id]).not_to be_nil 
      end
      
end    



    