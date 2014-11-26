Rails.application.routes.draw do
  root "static#home"
  resources :games do
    resources :coordinates do
      get :update_letter, on: :member
    end
  end
end
