Rails.application.routes.draw do
  resources :todos, only: [:index, :show, :new, :create]
end
