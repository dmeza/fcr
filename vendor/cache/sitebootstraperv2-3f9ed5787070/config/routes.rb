Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/fb_channel' => 'home#fb_channel', :as => 'fb_channel'
  match '/return_to_admin' => 'home#return_to_admin', :as => :return_to_admin
  namespace :admin do
    resources :users  do
      member do
        get :login_as, :resend_activation, :to_csv
        post :make_admin
      end
      collection do
        get :chart_data
      end
    end
  end
end
