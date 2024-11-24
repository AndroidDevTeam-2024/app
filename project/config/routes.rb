Rails.application.routes.draw do
  resources :messages
  resources :commodities
  resources :users
  resources :deals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  
  # Deal
  post "/deal/comment" => "deals#comment"
  post "/deal/post" => "deals#post"
  get "/deal/find_by_id/:id" => "deals#find_by_id"
  get "/deal/find_by_person/:id" => "deals#find_by_person"

  # User
  post "user/register" => "users#register"
  post "user/login" => "users#login"
  get "user/find_by_id/:id" => "users#find_by_id"

  # Commodity
  post "commodity/register" => "commodities#register"
  get "commodity/find_by_category/:category" => "commodities#find_by_category"
  get "commodity/find_by_publisher/:publisher" => "commodities#find_by_publisher"
  get "commodity/find_all" => "commodities#find_all"
  get "commodity/find_by_id/:id" => "commodities#find_by_id"
  

  # Message
  post "message/send" => "messages#send_message"
  get "message/find_by_id/:id" => "messages#find_by_id"
  get "message/find_by_receiver/:receiver" => "messages#find_by_receiver"
  
end
