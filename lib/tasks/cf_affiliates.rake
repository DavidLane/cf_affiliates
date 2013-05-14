require 'nokogiri'
require 'open-uri'

namespace :cf_affiliates do
  desc "Connect to .com and import the affiliate data"
  task :scrape => :environment do
    ScrapeLogger = Logger.new("#{Rails.root}/log/scrape.log")    
    
    url = "http://www.crossfit.com/cf-info/main_affil.htm"
    doc = Nokogiri::HTML(open(url))
    
    @timestamp_regex = /<!-- ([0-9\-\s:]+) -->/    
    
    @raw_doc = doc    
    @raw_doc_timestamp = @raw_doc.inner_html.match(@timestamp_regex)[1]
    
    unless Scrape.count.eql?(0)
      ScrapeLogger.info(DateTime.now.strftime + ": Comparing " + @raw_doc_timestamp + " to " + Scrape.last.hq_timestamp)
      @run_import = !@raw_doc_timestamp.eql?(Scrape.last.hq_timestamp)
    else
      @run_import = true
    end
       
    # Check to see if it's more up to date than our current version
    if @run_import.eql?(true)
      ScrapeLogger.info(DateTime.now.strftime + ": Running update") # Log that this ran
      puts "Running update"
      @scrape = Scrape.new # Save the scrape!
      @scrape.raw_html = @raw_doc.inner_html
      @scrape.hq_timestamp = @raw_doc_timestamp
      @scrape.save 
      
      # Create array for each affiliate that we added
      @new_affiliate_array = []
       
      @affiliates_div = @raw_doc.inner_html
      
      @regex_for_each_line = /(<a.*?br\s?\/?>)/
      
      @affiliates_array = @affiliates_div.scan(@regex_for_each_line)
      
      ScrapeLogger.info(DateTime.now.strftime + ": Affiliates Count = " + @affiliates_array.count.to_s) # Log that this ran
      
      puts "Affiliate count: " + @affiliates_array.count.to_s      
      
      unless @affiliates_array.blank?
        @affiliates_array.each do |scrape_line|
  
        # Regex Pattern
        # Epic Regex Winnings!
        # /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
        # a[0] = the whole string
        # a[1] = website url
        # a[2] = affiliate title
        # a[3] = location data TODO:This needs parsing and saving
        
        # @regex = /(<a href="(http:\/\/[A-Za-z0-9\/\.\-]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
        # Updated Regex. Hope this is a bit more thorough because it looks EPIC!
        # @regex = /([<a-z\s=]+["']+([:\/A-Za-z\-\.0-9_\?#=!]+)["']+[a-z=\s'"_]+>([A-Za-z0-9\-\s\.\(\)&;]+)[<\/A-Za-z>]+([\w\s\-,&;\.]+)[br\/<\s]+>)/
        # [<a href=][']([http://www.crossfit-sheffield.co.uk/])['][target='_blank']>([CrossFit Sheffield])[</a>]([ - Sheffield,&nbsp;United Kingdom])[<br />]      
        # Another regex. Identifies the elements we want with lazy *'s to make sure it gets all content regardless of if it's valid
        @regex = /(<.+??="(.+?)(?="|').*?>(.+?)<.+?>(.+?)?<.+?>)/
        # 0 - Full Match
        # 1 - Website
        # 2 - Name
        # 3 - Location
        
        @line = scrape_line[0]
        
        @affiliate_line = @regex.match(@line)
        
        # @affiliates_array.each do |a|
          # puts a[3]
          # More Epic Regex Winnings!
          # - Denver,&nbsp;CO
          # - Freiburg, BW,&nbsp;Germany  
          
          # New Regex
          @location_regex = /( - ([0-9A-Za-z\s\-\.&;\(\)]+),&nbsp;([A-Z]{2})?([A-Za-z\s]+)?)/
          # 1 - Full Match
          # 2 - City
          # 3 - State
          # 4 - Country
          
          # Old Regex
          #@location_regex = /( - ([A-Za-z\s]+),(\s|&nbsp;)([a-zA-Z\s]+)(,&nbsp;([A-Za-z\s]+))?)/
          # 1 = Whole thing
          # 2 = City
          # 4 = State
          # 5 = Country (optional)
          
          @match = @location_regex.match(@affiliate_line[4])
          
          puts @affiliate_line[4]
          
          unless @match.blank?
            
            @title = @affiliate_line[3]
            @website = @affiliate_line[2]
            @city = @match[2]
            
            unless @match[3].blank?
              @state = @match[3]
              @country = "United States"
            else
              @state = nil            
            end
            
            if @match[4].blank?
              unless @country.present?
                @country = nil
              end
            else
              @country = @match[4]
            end
            
            @original_scrape_data = @affiliate_line[0]
            
            # puts @match.inspect 
            
            # Don't want to overwrite data anymore
            if @affiliate = Affiliate.find_by_title(@title)
            #  @affiliate.city = @city unless @city.blank?
            #  @affiliate.state = @state unless @state.blank?
            #  @affiliate.country = @country unless @country.blank?
            #  @affiliate.original_scrape_data = @original_scrape_data
            #  @affiliate.save 
            else
              # Can't find this affiliate
              # Create a new one and notify Admin to confirm
              @affiliate = Affiliate.new
              @affiliate.title = @title unless @title.blank?
              @affiliate.website = @website unless @website.blank?
              @affiliate.city = @city unless @city.blank?
              @affiliate.state = @state unless @state.blank?
              @affiliate.country = @country unless @country.blank?
              @affiliate.original_scrape_data = @original_scrape_data
              @affiliate.save!
              
              ScrapeLogger.info(DateTime.now.strftime + ": New Affiliate found and added - " + @affiliate.title)
              
              @new_affiliate_array.push(@affiliate)
              
            end
         end
        end
      end
      #ScraperMailer.new_affiliates_added(@new_affilliate_array).deliver
      puts "New affiliates:" + @new_affiliate_array.count.to_s      
    else
      ScrapeLogger.info(DateTime.now.strftime + ": No update required")   
    end  
  end
  
  desc "See which affiliates are missing from our import"
  task :compare_imported_to_data => :environment do
    
    # Grab the whole line
    @regex = /(<a.*?br\s?\/?>)/
    @complete_array = Scrape.last.raw_html.scan(@regex)
    
    total_count = @complete_array.count
    
    missing_count = 0
    
    unless @complete_array.blank?
      @complete_array.each do |aff|
        unless Affiliate.exists?(:original_scrape_data => aff[0])
          missing_count += 1
          puts aff.inspect
        end
      end
    end
    
    puts "Total count = " + total_count.to_s
    puts "Missing count = " + missing_count.to_s
  end
  
  desc "Get geolocation from postcode"
  task :get_geolocations_from_postcode => :environment do
    @root_url = "http://uk-postcodes.com/postcode/"
    @extention = ".xml"
    @affiliates = Affiliate.uk
    
    unless @affiliates.blank?
      @affiliates.each do |a|
        unless @affilates.has_geolocation_data?
          @postcode = a.postcode.gsub(/\s+/, "")
          @url = @root_url + @postcode + @extention
          doc = Nokogiri::HTML(open(@url))
          puts doc
        end
      end
    end
  end

end
