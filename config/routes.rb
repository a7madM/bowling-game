Rails.application.routes.draw do
  constraints format: :json do
    resources :games, only: %i[create show]
    resources :rolls, only: %i[create]
  end
end
