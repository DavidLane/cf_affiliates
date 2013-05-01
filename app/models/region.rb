class Region < ActiveRecord::Base
  has_many :affiliates
  attr_accessible :title
end
