#!/usr/bin/env ruby
#
# A really simple mock rack app

def usage()
  puts "You have to specify a message"
  exit 1
end

def rack(message)
  usage if message.empty?
  rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["#{message}"]] }
  puts rack_proc.call({})
end

rack ARGV.join(' ')

