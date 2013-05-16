class Region < ActiveRecord::Base
  has_many :affiliates
  attr_accessible :title, :coords_lat, :coords_long
end
