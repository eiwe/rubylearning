#!/usr/bin/env ruby
#

require 'net/http'
require 'open-uri'
require 'hpricot'
require 'nokogiri'

url = URI.parse('http://satishtalim.github.com/webruby/chapter3.html')
match_regex = /\bthe\b/i

def match_nethttp(url, regex)
  Net::HTTP.start(url.host, url.port) do |http|
    req = Net::HTTP::Get.new(url.path)
    results = http.request(req).body
    results.scan(regex).count
  end
end

def match_openuri(url, regex)
  results = open(url)
  results.readlines.join.scan(regex).count
end

def match_hpricot(url, regex)
  results = Hpricot(open(url))
  results.inner_html.scan(regex).count
end

def match_nokogiri(url, regex)
  results = Nokogiri::HTML(open(url))
  results.to_s.scan(regex).count
end

net_http_count = match_nethttp(url, match_regex)
puts "The word 'the' appears #{net_http_count} times using net/http"

openuri_count = match_openuri(url, match_regex)
puts "The word 'the' appears #{openuri_count} times using open-uri"

hpricot_count = match_hpricot(url, match_regex)
puts "The word 'the' appears #{hpricot_count} times using hpricot"

nokogiri_count = match_nokogiri(url, match_regex)
puts "The word 'the' appears #{nokogiri_count} times using nokogiri"
