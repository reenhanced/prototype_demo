Bridgeway::Application.routes.draw do

  resources :family_cards, :except => [:index, :destroy] do
    get  'search', :on => :collection
    resources :students
    resources :family_members
    resources :call_logs
    resources :qualifiers
  end

  match 'dashboard' => 'family_cards#index'

  devise_for :users, :skip => [:sessions]
  as :user do
    get  'login'  => 'devise/sessions#new',     :as => :new_user_session
    post 'login'  => 'devise/sessions#create',  :as => :user_session
    get  'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root :to => 'family_cards#search'
end
