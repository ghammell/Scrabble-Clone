Rails.application.routes.draw do
  root "static#home"
  resources :games do
    resources :coordinates
  end
end
