class AffiliateCertification < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :certification
  # attr_accessible :title, :body
end
