CfAffiliateScraper::Application.routes.draw do

  resources :affiliates do
    resources :affiliate_update_requests
  end
  
  resources :new_affiliate_reuquests

  resources :regions
  
  # API Routes
  match "api" => "api#index", :as => :api_index
  match "api/get_regions" => "api#get_regions", :as => :api_get_regions
  match "api/get_region/:id" => "api#get_region", :as => :api_get_region  
  match "api/get_cities" => "api#get_cities", :as => :api_get_cities
  match "api/get_countries" => "api#get_countries", :as => :api_get_countries
  match "api/get_affiliates_by_region/:id" => "api#get_affiliates_by_region", :as => :api_get_affiliate_by_region 
  match "api/get_affiliates_by_country/:country" => "api#get_affiliates_by_country", :as => :api_get_affiliate_by_country
  match "api/get_affiliates_by_city/:city" => "api#get_affiliates_by_city", :as => :api_get_affiliate_by_city
  match "api/get_all_affiliates" => "api#get_all_affiliates", :as => :api_get_all_affiliates
  match "api/get_affiliate/:id" => "api#get_affiliate", :as => :api_get_affiliate

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "affiliates#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
