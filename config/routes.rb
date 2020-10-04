Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:index, :show, :new, :edit]
  end
  resources :songs do
    resources :artists, only: [:new, :edit]
  end
end
