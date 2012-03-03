require './droidfinder'
use DroidFinder::Search 
run Proc.new{|env|  [200, {"Content-Type" => "text/plain"}, ['Padawan, you must visit the jawa to find your droids.']] }
