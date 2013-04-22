require 'nokogiri'
require 'open-uri'

url = "http://www.crossfit.com/cf-info/main_affil.htm"
doc = Nokogiri::HTML(open(url))

@affiliates_div = doc

# Regex Pattern
# /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/

@regex = /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/

@affiliates_array = @affiliates_div.inner_html.scan(@regex)

@affiliates_array.each do |a|
  puts a[1]
  puts a[2]
end
