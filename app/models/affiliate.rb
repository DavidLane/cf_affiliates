class Affiliate < ActiveRecord::Base
  attr_accessible :name, :website, :city, :state, :country
end
