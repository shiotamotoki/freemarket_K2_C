Rails.application.routes.draw do
  root to: 'ok#index'
  get 'ok/index'
  get 'mypages' => 'mypages#index'
  get 'toppage' => 'toppage#main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
