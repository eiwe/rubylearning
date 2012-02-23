# simple_rack.rb

require 'rack'
def rack_method env
  [200, {"Content-Type"=>"text/plain"}, ["Command line argument you typed was: #{ARGV.join(' ')}"]]
end

Rack::Server.new( { :app => method(:rack_method), :server => 'webrick', :Port => 8500} ).start
