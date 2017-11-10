Rails.application.routes.draw do
  # Serve websocket cable requests in-process
   mount ActionCable.server => '/cable'

  devise_for :users, controllers: { registrations: "users/registrations",
                                    sessions: "users/sessions" }

  resources :users, only: [:index, :show, :edit, :update]
  resources :profiles do
   resources :chats, only: [:index, :show, :create]
  end
  resources :messages, only:[:create]
  root to: 'profiles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
