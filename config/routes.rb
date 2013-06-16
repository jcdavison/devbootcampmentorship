BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'users#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in', to: 'sessions#new'
  match '/thank_you', to: 'mentors#thanks'
  resources :users, :cohorts, :mentors, :boots
  root :to => "sessions#new"
end
