Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'packages/fetch'
    end
  end

  resources :packages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
