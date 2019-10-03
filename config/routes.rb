Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',

    }

    devise_scope :user do
      get 'uses/before_sign_up' => 'devise/registrations#before_signup', as: :before_signup_user_registration
      post 'uses/before_sign_up(.:format)' => 'devise/registrations#before_signup'
      post 'users/sign_up' => 'users/registrations#new'
    end

    get 'ok/index'
    root "ok#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
end
