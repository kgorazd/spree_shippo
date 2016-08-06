Spree::Core::Engine.routes.draw do
        
	namespace :admin do
		get 'shippo/settings', :to => 'shippo#show', :as => "shippo_settings"
		get 'shippo/orders/', :to => 'shippo#view_orders', :as => "shippo_orders"
		get 'shippo/order/:id', :to => 'shippo#view_order', :as => "shippo_order"
		get "goshipments/new_parcel", to: 'goshipments#new_parcel'
        post "goshipments/transactions", to: 'goshipments#transactions'
        post "goshipments/create_parcel", to: 'goshipments#create_parcel'
        get :new_parcel
		get "goshipments/return_parcel", to: 'goshipments#return_parcel'
        post "goshipments/return_label", to: 'goshipments#return_label'
        post "goshipments/return_transactions", to: 'goshipments#return_transactions'
        get "goshipments/refund", to: 'goshipments#refund'
  	    end
  	
  	namespace :api do
        get "goshipments/package", to: 'goshipments#package_type'
        post 'goshipments/update' => 'goshipments#receive'
    end
  
end
