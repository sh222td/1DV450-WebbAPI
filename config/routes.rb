Rails.application.routes.draw do
  #root 'events#index'
    
  #resources :users
  
  #post 'login'    => 'users#login',        :as => "login"
  #get  'logout'   => 'users#logout',       as:    :logout

  get '/events'    => 'events#index'
  
  
  namespace :api do
    resources :users, :positions, :tags, :events
end

end
