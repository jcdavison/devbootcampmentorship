BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'users#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in', to: 'sessions#new'
  resources :users, :cohorts, :mentors
  root :to => "main#index"
end
