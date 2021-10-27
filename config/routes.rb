Rails.application.routes.draw do
  get 'share/new'
  root to: "home#index"
  devise_for :users

  post 'file/attach' => 'file#attach'
  delete 'file/delete' => 'file#delete'

  get 'share/new' => 'share#new'
  post 'share/create' => 'share#create'
  delete 'share/delete' => 'share#delete'
end
