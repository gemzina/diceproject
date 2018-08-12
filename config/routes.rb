Rails.application.routes.draw do
  root 'games#index'
  resources :games
  post "/games/:id/make_bet", to: "games#make_bet"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
