# simple_rack.rb
require 'rack'
rack_proc = lambda { |env| [200, {}, ["Command line argument you typed was: #{ARGV.join(' ')}"]] }

Rack::Handler::Thin.run rack_proc, :Port => 8500
