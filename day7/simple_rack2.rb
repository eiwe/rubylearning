# simple_rack.rb

require 'rack'
def rack_method env
  [200, {"Content-Type"=>"text/plain"}, ["Command line argument you typed was: #{ARGV.join(' ')}"]]
end


Rack::Handler::Thin.run method(:rack_method), :Port => 8500
