Rails.application.routes.draw do
  
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post '/signup', to: 'authentication#signup'
      post '/login', to: 'authentication#login'
    end
  end
end


