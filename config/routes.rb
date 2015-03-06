Rails.application.routes.draw do
  
  root :to => redirect('/login')
    
  resources :users
  
  get '/apikeys'         => 'apikeys#show', as: :apikey
  get '/addAPI'          => 'apikeys#add'
  get '/delete'          => 'users#destroy'
  
  #post 'login'    => 'users#login',        :as => "/login"
  get '/login'    => 'users#login',        :as => "/login"
  get  '/logout'   => 'users#logout',       as:    :logout
  
  namespace :api do
    resources :users, :positions, :tags, :events
end

end
