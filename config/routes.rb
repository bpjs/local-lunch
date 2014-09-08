Rails.application.routes.draw do

  root to: 'communities#index'
  devise_for :members

  resources :communities, only: [:show, :index, :new, :create] do
    resources :restaurants, only: [:create]
    resources :groups, only: [:index, :create, :update]
  end
  resources :restaurants, only: [:show, :destroy]
  resources :groups, only: [:destroy]
  resources :members, except: [:index]
  resources :reviews, only: [:create, :edit, :update, :destroy]

  post "/members/:id/join_community/:community_id", to: "members#join_community", as: "member_join_community"
  post "/members/:id/leave_community/:community_id", to: "members#leave_community", as: "member_leave_community"

  post "/members/:id/join_group/:group_id", to: "members#join_group", as: "member_join_group"
  post "/members/:id/leave_group", to: "members#leave_group", as: "member_leave_group"

  get "yelp_call", to: "restaurants#yelp_call"
end
