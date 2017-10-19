Rails.application.routes.draw do

  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/fb_channel' => 'home#fb_channel', :as => 'fb_channel'

  get "info/historianew"

  get 'info/' => "info#index", as: :info

  get 'event/:id' => 'events#show', as: :event
  get 'event/:id/logged' => 'events#logged', as: :logged
  get 'join/:id' => 'events#join', as: :join

  get 'calendar' => 'home#calendar', as: :calendar

  get 'event/entry_list/:id' => 'admin/events#entry_list', as: :entry_list

  # match 'event/entry_list_csv/:id' => 'admin/events#entry_list_to_csv', as: :entry_list_to_csv
  get 'event/entry_list_to_xlsx/:id' => 'admin/events#entry_list_to_xlsx', as: :entry_list_to_xlsx

  get 'info/send_mail' => 'info#send_mail', as: :info_send_mail
  
  get 'responsable_autocomplete' => 'events#responsable_autocomplete'

  # Brigade Leader routes
  get 'brigades/dashboard' => 'brigades#dashboard', as: :brigades_dash
  get 'brigades/brigades' => 'brigades#index', as: :brigades_index
  get 'brigades/:id/view_event' => 'brigades#view_event', as: :view_event
  get 'brigades/:id/view_brigade' => 'brigades#view_brigade', as: :view_brigade
  post 'brigades/:id/add_brigadist' => 'brigades#add_brigadist', as: :add_brigadist
  post 'brigades/:id/remove_brigadist' => 'brigades#remove_brigadist', as: :remove_brigadist
  get 'admin/volunteers/volunteer_filter' => 'admin/volunteers#volunteer_filter', as: :volunteer_filter
  get 'admin/children/child_filter' => 'admin/children#child_filter', as: :child_filter
  get 'admin/polls/poll_filter' => 'admin/polls#poll_filter', as: :poll_filter
  get 'admin/events/events_filter' => 'admin/events#events_filter', as: :events_filter
  get 'admin/users/users_filter' => 'admin/users#users_filter', as: :users_filter
  
  namespace :admin do
    resource :dash

    resources :users do
      member do
        get :login_as, :resend_activation, :to_csv
        post :make_admin
      end
      collection do
        get :chart_data
      end
    end

    resources :volunteers do
      member do
        post :activate
      end
      collection do
        get :to_xlsx #, :to_csv
      end
    end
    
    resources :children do
      member do
        post :activate
      end
      collection do
        get :to_xlsx #, :to_csv

      end


    end

    resources :polls do
      member do
        post :activate
      end
      collection do
        get :to_xlsx #, :to_csv
        post :from_xlsx
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

    resources :hospitals do 

    end




  end


  get '/return_to_admin' => 'home#return_to_admin', :as => :return_to_admin

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
