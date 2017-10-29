Rails.application.routes.draw do
  get 'teams/index'
  get 'teams/:id', to: 'teams#show', as: :teams_show

  resources :games do
    resources :characters do
      resources :supports
    end
  end

  root 'teams#index'
end
