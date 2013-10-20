Leftright::Application.routes.draw do
  root to: 'screenshots#index'

  get '/publications' => 'publications#index'
  get '/screenshots' => 'screenshots#index'
  get '/:timestamp(/:left(/:right(/:section)))' => 'screenshots#index'
end
