Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

        namespace :customers do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end

        namespace :invoice_items do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end

        namespace :invoices do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end

        namespace :items do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
          get ':item_id/best_day', to: "best_day#show"
        end

        namespace :merchants do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end

        namespace :transactions do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end

        namespace :customers, only: [:show] do
          get ':customer_id/transactions', to: "transactions/search#index"
          get ':customer_id/invoices', to: "invoices/search#index"
        end

        namespace :invoice_items, only: [:show] do
          get ':invoice_item_id/item', to: "items/search#show"
          get ':invoice_item_id/invoice', to: "invoices/search#show"
        end

        namespace :invoices, only: [:show] do
          get ':invoice_id/transactions', to: "transactions/search#index"
          get ':invoice_id/items', to: "items/search#index"
          get ':invoice_id/invoice_items', to: "invoice_items/search#index"
          get ':invoice_id/customer', to: "customers/search#show"
          get ':invoice_id/merchant', to: "merchants/search#show"
        end

        namespace :items, only: [:show] do
          get ':item_id/invoice_items', to: "invoice_items/search#index"
          get ':item_id/merchant', to: "merchants/search#show"
        end



        resources :customers, only: [:index, :show]
        resources :items, only: [:index, :show]
        resources :invoice_items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
        resources :merchants, only: [:index, :show]
        resources :transactions, only: [:index, :show]
      end
    end
  end
