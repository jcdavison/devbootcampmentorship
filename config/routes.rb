BootBook::Application.routes.draw do

  namespace :api do
    namespace :v1, :constraints => {format: 'json'} do
      match "home" => "home#index"
    end
  end

  root :to => "api/v1/home#index"

end
