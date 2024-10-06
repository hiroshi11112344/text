Rails.application.routes.draw do
  
  get "user/new"
  get "login" => "user#login"
  post "login" => "user#login_form"
  post "logout" => "user#logout" 
  


  get "quizzes/new" => "quizzes#new"
  post "quizzes/create" => "quizzes#create"

  get "quizzes/index" => "quizzes#index"
  get "quizzes/:id" => "quizzes#show"
  post "quizzes/:id/check_answer", to: "quizzes#check_answer"


  get "user/new" => "user#new"
  get "user/index" => "user#index"

  get "/" => "home#top"









  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
