Rails.application.routes.draw do
  get 'teams/index'

  resources :characters do
    resources :supports
  end

  root 'teams#index'
end
