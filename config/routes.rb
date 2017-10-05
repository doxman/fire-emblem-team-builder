Rails.application.routes.draw do
  get 'teams/index'
  post 'teams/add_member'
  post 'teams/remove_member'

  resources :characters do
    resources :supports
  end

  root 'teams#index'
end
