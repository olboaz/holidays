Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  get "/send_mail" => 'places#send_mail'

  resources :places do
    post :get_barcode, on: :collection
  end

end
