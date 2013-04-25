require 'nokogiri'
require 'open-uri'

namespace :cf_affiliates do
  desc "TODO"
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
      @scrape = Scrape.new # Save the scrape!
      @scrape.raw_html = @raw_doc.inner_html
      @scrape.hq_timestamp = @raw_doc_timestamp
      @scrape.save 
      
      # Create array for each affiliate that we added
      @new_affiliate_array = []
       
      @affiliates_div = @scrape.raw_html
  
      # Regex Pattern
      # Epic Regex Winnings!
      # /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
      # a[0] = the whole string
      # a[1] = website url
      # a[2] = affiliate title
      # a[3] = location data TODO:This needs parsing and saving
      
      @regex = /(<a href="(http:\/\/[A-Za-z0-9\/\.]+)" target="_blank">([\w\s]+)<\/a>([\w\s\-,&;]+)?<br>)/
      
      @affiliates_array = @affiliates_div.scan(@regex)
      
      @affiliates_array.each do |a|
        puts a[3]
        # More Epic Regex Winnings!
        # - Denver,&nbsp;CO
        # - Freiburg, BW,&nbsp;Germany  
        
        # New Regex
        @location_regex = /( - ([A-Za-z\s]+),&nbsp;([A-Z]{2})?([A-Za-z\s]+)?)/
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
        
        @match = @location_regex.match(a[3])
        
        unless @match.blank?
          
          @title = a[2]
          @website = a[1]
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
          
          @original_scrape_data = a[0]
          
          puts @match.inspect 
          
          # Don't want to overwrite data anymore
          #if @affiliate = Affiliate.find_by_title(a[2])
          #  @affiliate.city = @city unless @city.blank?
          #  @affiliate.state = @state unless @state.blank?
          #  @affiliate.country = @country unless @country.blank?
          #  @affiliate.original_scrape_data = @original_scrape_data
          #  @affiliate.save 
          #else
            # Can't find this affiliate
            # Create a new one and notify Admin to confirm
            @affiliate = Affiliate.new
            @affiliate.title = @title unless @title.blank?
            @affiliate.website = @website unless @website.blank?
            @affiliate.city = @city unless @city.blank?
            @affiliate.state = @state unless @state.blank?
            @affiliate.country = @country unless @country.blank?
            @affiliate.original_scrape_data = @original_scrape_data
            @affiliate.save
            
            ScrapeLogger.info(DateTime.now.strftime + ": New Affiliate found and added - " + @affiliate.title)
            
            @new_affiliate_array.push(@affiliate)
            
          #end
        end
        #ScraperMailer.new_affiliates_added(@new_affilliate_array).deliver
      end
    else
      ScrapeLogger.info(DateTime.now.strftime + ": No update required")   
    end  
  end

end
