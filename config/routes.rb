require "resque/server"

BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in'  => redirect('/auth/linkedin')
  match '/thank_you', to: 'mentors#thanks'
  match '/mentor_sign_up', to: 'users#new_mentor'
  match '/notify', via: :get, to: 'cohorts#notify'
  match '/message_cohort', via: :post, to: 'cohorts#notify'
  match '/boot_sign_up', to: 'users#new_boot'
  resources :users, :cohorts, :pairings, :commitments, :messages

  mount Resque::Server.new, :at => "/resque"

  root :to => "users#index"
end
