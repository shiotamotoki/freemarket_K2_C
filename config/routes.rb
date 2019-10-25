Rails.application.routes.draw do
  
  devise_for :users

    devise_scope :user do
      get 'uses/before_sign_up' => 'devise/registrations#before_signup', as: :before_signup_user_registration
      post 'uses/before_sign_up(.:format)' => 'devise/registrations#before_signup'
      post 'users/sign_up' => 'users/registrations#new'
      get 'users/new2' => 'devise/registrations#new2', as: :new2_user_registration
      post 'users/new2(.:format)' => 'devise/registrations#new2'
      get 'users/new3' => 'devise/registrations#new3', as: :new3_user_registration
      post 'users/new3(.:format)' => 'devise/registrations#new3'
      get 'users/new4' => 'devise/registrations#new4', as: :new4_user_registration
      post 'users/new4(.:format)' => 'devise/registrations#new4'
      get 'users/new5' => 'devise/registrations#new5', as: :new5_user_registration
      post 'users/new5(.:format)' => 'devise/registrations#new5'
      
    end

  #root to: 'ok#index'
  root to: 'items#index'

  #get 'itemsshow' => 'items#show'
  #get 'users/logout' => 'users#logout'
  #get 'users/credit' => 'users#credit'
  #get 'itemscheck' => 'items#check'
  #get 'itemsindex' => 'items#index'
  #get 'items/:id' => 'items#show'
  
  resources :mypages, only: [:index,:edit]do
    collection do
      get "credit", to: "mypages#credit"
      get "logout", to: "mypages#logout"
      get "profile", to: "mypages#profile"
      get "identification", to: "mypages#identification"
    end
  end
  resources :items, only: [:index, :show, :new] do
    collection do
      get "check", to: "items#check"
      
    end
    
  end
 
  
  resources :users
end