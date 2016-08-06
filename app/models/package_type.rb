class PackageType < ActiveRecord::Base
    belongs_to :SpreeOrder

	def self.mass_units
		['lb', 'oz', 'g', 'kg']

	end

	def self.insurance_currency
		['USD']
	end

	def shipment__box_details
		"#{parcel} (#{dimension_length} x #{dimension_width} x #{dimension_height} #{dimension_unit})"
	end

	def create_shippo_parcel(weight, mass_unit)
		GoShippo::Parcel.create(self.dimension_length.to_f, self.dimension_width.to_f, self.dimension_height.to_f, self.dimension_unit, weight, mass_unit)
	end
	
end
