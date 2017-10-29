Rails.application.routes.draw do
  get 'teams/index'

  resources :games do
    resources :characters do
      resources :supports
    end
  end

  root 'teams#index'
end
