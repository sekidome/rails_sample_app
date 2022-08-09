Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  get '/help', to: 'static_pages#help', as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/home', to: 'static_pages#home'
  root 'static_pages#home'
end
