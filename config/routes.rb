Leftright::Application.routes.draw do
  root to: 'screenshots#index'

  get '/publications' => 'publications#index'
  get '/screenshots' => 'screenshots#index'
  get '/:section(/:left(/:right(/:timestamp)))' => 'screenshots#index'
end
