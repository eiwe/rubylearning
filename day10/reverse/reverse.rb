# reverse.rb
#
# A dead simple reversing application
#
require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

post '/reverse' do
  haml :reverse
end
