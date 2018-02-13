Rails.application.routes.draw do
  match '*all', to: 'application#preflight', via: [:options]

  get ':provider/request_token', to: 'authentication#request_token'
  get ':provider/access_token',  to: 'authentication#access_token'

  post 'login_with_email_pwd', to: 'authentication#login_with_email_pwd'
  post 'register_with_email_pwd', to: 'authentication#register_with_email_pwd'

  resources :blabs, only: [:index, :create, :show]
  resources :projects, only: [:index, :create, :show]

  match '*all', to: 'application#index', via: [:get]
end
