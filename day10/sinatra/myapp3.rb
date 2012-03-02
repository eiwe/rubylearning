# myapp3.rb
require 'sinatra'
require 'haml'

get '/' do
  haml :home
end

post '/display' do
  haml :show
end
