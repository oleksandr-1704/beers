Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: redirect('beers')

  resources 'beers', only: [:index] do
    collection do
      get :search
    end
  end
end
