# my_rack2.rb
require 'rack'
def my_method(env)
  [200, {}, ["Method called"]]
end

Rack::Server.new( { 
  :app => :my_method, 
  :server => 'webrick', 
  :Port => 9876
} ).start
