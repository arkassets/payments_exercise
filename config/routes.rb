Rails.application.routes.draw do
  resources :loans, defaults: {format: :json}, only: [:index, :create, :show] do
    member do
      get 'payments'
    end
  end
  resources :payments, defaults: {format: :json}, only: [:create, :show]
end
