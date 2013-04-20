require 'nokogiri'
require 'open-uri'

url = "http://www.crossfit.com/cf-info/main_affil.htm"
doc = Nokogiri::HTML(open(url))

@affiliates_div = doc
puts @affiliates_div
