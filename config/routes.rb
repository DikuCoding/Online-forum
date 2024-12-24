Rails.application.routes.draw do
  
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post '/signup', to: 'authentications#signup'
      post '/login', to: 'authentications#login'
    end
  end
end


