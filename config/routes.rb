 Voluntarios::Application.routes.draw do

  get "info/historianew"

  match 'info/' => "info#index", as: :info

  match 'event/:id' => 'events#show', as: :event
  match 'event/:id/logged' => 'events#logged', as: :logged
  match 'join/:id' => 'events#join', as: :join

  match 'calendar' => 'home#calendar', as: :calendar

  match 'event/entry_list/:id' => 'admin/events#entry_list', as: :entry_list

  # match 'event/entry_list_csv/:id' => 'admin/events#entry_list_to_csv', as: :entry_list_to_csv
  match 'event/entry_list_to_xlsx/:id' => 'admin/events#entry_list_to_xlsx', as: :entry_list_to_xlsx

  match 'info/send_mail' => 'info#send_mail', as: :info_send_mail
  
  get 'responsable_autocomplete' => 'events#responsable_autocomplete'

  # Brigade Leader routes
  match 'brigades/dashboard' => 'brigades#dashboard', as: :brigades_dash
  match 'brigades/brigades' => 'brigades#index', as: :brigades_index
  match 'brigades/:id/view_event' => 'brigades#view_event', as: :view_event
  match 'brigades/:id/view_brigade' => 'brigades#view_brigade', as: :view_brigade
  match 'brigades/:id/add_brigadist' => 'brigades#add_brigadist', as: :add_brigadist
  match 'brigades/:id/remove_brigadist' => 'brigades#remove_brigadist', as: :remove_brigadist
  match 'admin/volunteers/volunteer_filter' => 'admin/volunteers#volunteer_filter', as: :volunteer_filter
  match 'admin/events/events_filter' => 'admin/events#events_filter', as: :events_filter
  match 'admin/users/users_filter' => 'admin/users#users_filter', as: :users_filter
  namespace :admin do
    resource :dash
    resources :volunteers do
      member do
        post :activate
      end
      collection do
        get :to_xlsx #, :to_csv
      end
    end
    resources :brigades
    resources :events do
      member do
        get :edit_new
        post :add_image
        delete :destroy_image, :remove_participant
      end
    end
    get 'responsable_autocomplete' => 'events#responsable_autocomplete'
  end

  

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
