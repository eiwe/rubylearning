# reverse.rb
#
# A dead simple reversing application
#
require 'sinatra'
require 'haml'

use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'secret'
end

get '/' do
  haml :index
end

post '/reverse' do
  haml :reverse
end
