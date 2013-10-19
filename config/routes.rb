Leftright::Application.routes.draw do
  root to: 'screenshots#index'

  resources :screenshots, only: :index
end
