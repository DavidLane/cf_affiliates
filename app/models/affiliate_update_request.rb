class AffiliateUpdateRequest < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :region
  
  after_create :send_alert
  
  attr_accessible :requester_email, :affiliate_id, :new_title, :new_email, :new_telephone_number, :new_address, :new_postcode, :new_website,
  :new_city, :region_id
  
  validates :requester_email, :presence => true
  
  def send_alert
    #AffiliateUpdateRequestMailer.new_request_added(self).deliver
  end
  
  def populate_from_affiliate(affiliate)
    self.new_title = affiliate.title
    self.new_email = affiliate.contact_email
    self.new_telephone_number = affiliate.contact_number
    self.new_email = affiliate.contact_email
    self.new_address = affiliate.address
    self.new_postcode = affiliate.postcode
    self.new_city = affiliate.city
    self.new_website = affiliate.website
    self.region_id = affiliate.region_id
  end
end
