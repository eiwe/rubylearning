# my_rack_proc2.rb
# 
# Super simple rack example

require 'rack'
my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]] }

Rack::Server.new( { 
  :app => my_rack_proc, 
  :server => 'webrick', 
  :Port => 9876
} ).start
