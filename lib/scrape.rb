require "../config/environment"
require 'nokogiri'
require 'open-uri'

#url = "http://www.crossfit.com/cf-info/main_affil.htm"
#doc = Nokogiri::HTML(open(url))

#@affiliates_div = doc

#@scrape = Scrape.new
#@scrape.raw_html = doc.inner_html
#@scrape.save

@affiliates_div = Scrape.last.raw_html

# Regex Pattern
# Epic Regex Winnings!
# /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
# a[0] = the whole string
# a[1] = website url
# a[2] = affiliate title
# a[3] = location data TODO:This needs parsing and saving

# @regex = /(<a href="(http:\/\/[A-Za-z0-9\/\.\-]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
# Updated Regex. Hope this is a bit more thorough because it looks EPIC!
@regex = /<[a-z\s=]+["']+([:\/A-Za-z\-\.]+)["']+[a-z=\s'"_]+>([A-Za-z0-9\-\s]+)[<\/A-Za-z>]+([\w\s\-,&;]+)[a-z\/<>\s]+/
# <[a href=][']([http://www.crossfit-sheffield.co.uk/])['][target='_blank']>([CrossFit Sheffield])[</a>]([ - Sheffield,&nbsp;United Kingdom])[<br />]

@affiliates_array = @affiliates_div.scan(@regex)

@affiliates_array.each do |a|
  puts a[3]
  # More Epic Regex Winnings!
  # - Denver,&nbsp;CO
  # - Freiburg, BW,&nbsp;Germany  
  @location_regex = / - ([A-Za-z]+),(\s|&nbsp;)([a-zA-Z])(,&nbsp;([A-Za-z]+))?/
  # 1 = City
  # 3 = State
  # 5 = Country (optional)
  
  @match = @location_regex.match(a[3])
  
  unless @match.blank?
  
    @match.inspect
    
    @city = @match[1]
    @state = @match[3]
    @country = @match[5]
    
    if @affiliate = Affiliate.find_by_title(a[2])
    #  @affiliate = Affiliate.new
    #  @affiliate.title = a[2]
    #  @affiliate.website = a[1]
      @affiliate.city = @city unless @city.blank?
      @affiliate.state = @state unless @state.blank?
      @affiliate.country = @country unless @country.blank?
      @affiliate.save  
    end
  end
 
end
