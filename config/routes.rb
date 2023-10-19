Rails.application.routes.draw do
  get 'shopifywebhook/order_update'
  root 'users#index'
  post 'shopify_webhook/order_created', to: 'shopifywebhook#order_created'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
