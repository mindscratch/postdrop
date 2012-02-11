 PostDrop::Application.routes.draw do

  get "users/profile"

  resources :posts

  root :to => "home#index"

  post "authentications/:provider", to: "authentications#create"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/login" => "sessions#new", :as => :signin
  match "/signout" => "sessions#destroy", :as => :signout

   resources :identities

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
