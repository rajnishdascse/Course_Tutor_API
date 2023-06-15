Rails.application.routes.draw do
  resources :courses do
    resources :tutors, only: [:create]
  end
end
