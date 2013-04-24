class Scrape < ActiveRecord::Base
  attr_accessible :raw_html, :hq_timestamp
end
