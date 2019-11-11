Rails.application.routes.draw do
  
  get 'purchase/index'
  get 'purchase/done'
  get 'credit_cards/new'
  get 'credit_cards/show'
  post   '/like/:item_id' => 'likes#like',   as: 'like'
  delete '/like/:item_id' => 'likes#unlike', as: 'unlike'

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

  root to: 'items#index'
  get 'mypages' => 'mypages#index'
  get 'itemsshow' => 'items#show'
  get 'users/logout' => 'users#logout'
  get 'users/credit' => 'users#credit'
  get 'itemscheck' => 'items#check'
  get 'itemsindex' => 'items#index'

  resources :mypages, only: [:index,:edit]do
    collection do
      get "credit", to: "mypages#credit"
      get "logout", to: "mypages#logout"
      get "profile", to: "mypages#profile"
      get "identification", to: "mypages#identification"     
    end
  end

  resources :items, only: [:index, :show, :new, :destroy, :edit, :create] do
    collection do
      get "check/:id(.:format)", to: "items#check"
      get 'child_category'
      get 'grandchild_category'
      get 'size'
      get 'search'
    end
  end

  resources :credit_cards, only: [:new, :show] do
    collection do
      post  'new', to: 'credit_cards#new'
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
    end
  end
  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      get 'done/:id(.:format)', to: 'purchase#done'
    end
    member do
      post 'pay', to: 'purchase#pay'
    end
  end
 
  resources :signups do
    collection do
      get :registration
      post :registration
      get :phone
      get :address
      get :credit
      get :done
    end
  end
  
  resources :users
end

