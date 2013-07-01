BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in'  => redirect('/auth/linkedin')
  match '/thank_you', to: 'mentors#thanks'
  match '/mentor_sign_up', to: 'users#new_mentor'
  match '/notify', via: :get, to: 'cohorts#notify'
  match '/boot_sign_up', to: 'users#new_boot'
  resources :users, :main, :cohorts, :pairings
  root :to => "users#index"
end
