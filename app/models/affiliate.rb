class Affiliate < ActiveRecord::Base
  has_many :affiliate_certifications
  has_many :certifications, :through => :affiliate_certifications
  
  attr_accessible :title, :website, :city, :state, :country, :original_scrape_data,
  :coords_lat, :coords_long, :contact_name, :contact_number, :contact_email, :address,
  :postcode, :region
  
  # accepts_nested_attributes_for :certifications, :affiliate_certifications
  
  scope :uk, where(:country => "United Kingdom").order(:title)
end
