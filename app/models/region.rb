class Region < ActiveRecord::Base
  has_many :affiliates
  attr_accessible :title, :coords_lat, :coords_long
  
  def has_coords?
    if self.coords_lat.present? and self.coords_long.present?
      return true
    end
  end
end
