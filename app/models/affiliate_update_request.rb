class AffiliateUpdateRequest < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :region
  
  attr_accessible :requester_email, :affiliate_id, :new_title, :new_email, :new_telephone_number, :new_address, :new_postcode, :new_website,
  :new_city, :region_id
  
  validates :requester_email, :presence => true
end
