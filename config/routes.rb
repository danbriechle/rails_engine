Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        namespace :items do
          get '/find', to: "search#show"
        end

        namespace :items do
          get ':item_id/best_day', to: "best_day#show"
        end

        resources :items, only: [:index, :show]
        resources :customers, only: [:index, :show]
        resources :invoice_items, only: [:index, :show]
      end
    end
  end
