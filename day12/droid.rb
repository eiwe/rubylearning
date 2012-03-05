require 'sinatra'
require './droidfinder'
use DroidFinder::Search

use Rack::Auth::Basic, "Restricted Area" do |user, password|
    user == 'darth' && password == 'vader'
end

get '/' do
    "Hello Star Wars and Ruby fans! I hope you find the droid..."
end
