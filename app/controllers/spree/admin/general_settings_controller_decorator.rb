module Spree
  module Admin
    class GeneralSettingsController 

      private
        def store_params
          params.require(:store).permit!
        end
    end
  end
end