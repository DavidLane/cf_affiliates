require 'nokogiri'
require 'open-uri'

url = "http://www.crossfit.com/cf-info/main_affil.htm"
doc = Nokogiri::HTML(open(url))

# Regex Pattern

# /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/

@affiliates_div = doc
puts @affiliates_div
