class Affiliate < ActiveRecord::Base
  attr_accessible :title, :website, :city, :state, :country, :original_scrape_data
end
