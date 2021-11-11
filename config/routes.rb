Rails.application.routes.draw do
  get '/ips', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/top100' =>  'apis#top100'
      post '/store_ip' => 'apis#request_handler'
      put '/clear' => 'apis#clear'
    end
  end
end
