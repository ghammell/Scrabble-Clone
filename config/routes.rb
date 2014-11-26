Rails.application.routes.draw do
  root "static#home"
  resources :games do
    resources :coordinates do
      get :update_letter, on: :member
      get :submit_word, on: :collection
      get :reset_word, on: :collection
    end
  end
end
