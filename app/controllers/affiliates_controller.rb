class AffiliatesController < ApplicationController
  def index
    @affiliates = Affiliate.uk.all
  end
  
  def country
    
  end
  
  def state
    
  end
  
  def show
    @affiliate = Affiliate.find_by_id(params[:id])
  end
end
