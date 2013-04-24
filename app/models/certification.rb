class Certification < ActiveRecord::Base
  has_many :affiliate_certifications
  has_many :affiliates, :through => :affiliate_certifications
  
  attr_accessible :title
end
