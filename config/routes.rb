Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'application#home'
  get '/list_dogs' => 'application#list_dogs'
  get '/show_dog/:id'  => 'application#show_dog'
  get '/new_dog' => 'application#new_dog'
  post 'create_dog' => 'application#create_dog'
end
