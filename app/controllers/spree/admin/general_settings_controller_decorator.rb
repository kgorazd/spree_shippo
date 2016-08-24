Spree::Admin::GeneralSettingsController.class_eval do

  private
    def store_params
      params.require(:store).permit!
    end
end