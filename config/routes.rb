Rails.application.routes.draw do
  get 'teams/index'
  match 'teams/add_member', via: [:get, :post]
  match 'teams/remove_member', via: [:get, :post]

  resources :characters do
    resources :supports
  end

  root 'teams#index'
end
