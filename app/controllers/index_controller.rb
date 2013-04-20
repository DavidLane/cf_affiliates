class IndexController < ApplicationController
	require 'nokogiri'
  require 'open-uri'
	def index	
		url = "http://www.crossfit.com"
		doc = Nokogiri::HTML(open(url))
		
		@affiliates_div = doc.at_css("div#main_affil")
		logger.info(@affiliates_div.css("a").inspect)
	end
end
