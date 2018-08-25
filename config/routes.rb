Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  constraints format: :json do
    resources :games, only: %i[create show]
    resources :rolls, only: %i[create]
  end
end
