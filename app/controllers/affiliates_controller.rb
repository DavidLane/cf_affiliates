class AffiliatesController < ApplicationController
  def index
    @affiliates = Affiliate.uk.all
    @regions = Region.all
  end
  
  def country
    
  end
  
  def state
    
  end
  
  def show
    @affiliate = Affiliate.find_by_id(params[:id])
    @affiliate_update_request = AffiliateUpdateRequest.new
    @affiliate_update_request.region = @affiliate.region
    @affiliate_update_request.affiliate = @affiliate
  end
  
  def get_typeahead_data
    @affiliates = Affiliate.all
  end
end
