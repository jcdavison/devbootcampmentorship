BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in'  => redirect('/auth/linkedin')
  match '/thank_you', to: 'mentors#thanks'
  match '/sign_up', to: 'users#new'
  resources :users, :main
  root :to => "users#index"
end
