Rails.application.routes.draw do
  get 'shopifywebhook/order_update'
  root 'users#index'
  post 'shopify_webhook/order_updated', to: 'shopifywebhook#order_updated'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
