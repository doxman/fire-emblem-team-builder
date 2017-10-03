Rails.application.routes.draw do
  resources :characters do
    resources :supports
  end
end
