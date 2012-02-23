# simple_rack.rb
require 'rack'

def my_method(env)
  [200, {}, ["#{ARGV}"]]
end

Rack::Handler::WEBrick.run method(:my_method), :Port => 8500
