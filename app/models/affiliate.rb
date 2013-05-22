class Affiliate < ActiveRecord::Base
  has_many :affiliate_certifications
  has_many :certifications, :through => :affiliate_certifications
  has_many :affiliate_update_requests
  belongs_to :region
  
  attr_accessible :title, :website, :city, :state, :country, :original_scrape_data,
  :coords_lat, :coords_long, :contact_name, :contact_number, :contact_email, :address,
  :postcode, :region_id
  
  # accepts_nested_attributes_for :certifications, :affiliate_certifications
  
  scope :uk, where("country = :united_kingdom OR country = :ireland OR country = :iom", {:united_kingdom => "United Kingdom", :ireland => "Ireland", :iom => "Isle Of Man"})
  
  def has_geolocation_data?
    if self.coords_lat.present? and self.coords_long.present?
      return true
    end
  end
  
  def has_postcode?
    return self.postcode.present?
  end
end
