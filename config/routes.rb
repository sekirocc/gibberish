Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users

      resources :gibbers do
        collection do
          get 'list_public'
        end
      end

      post '/account/sign_in', to: 'account#sign_in'
      post '/account/sign_up', to: 'account#sign_up'
      post '/account/refresh_token', to: 'account#refresh_token'

    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
