BootBook::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/sign_in', to: 'sessions#new'
  root :to => "main#index"
end
