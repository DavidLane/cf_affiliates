class ApiController < ApplicationController

  def index
    # Nothing in here
  end
  
  def get_regions
    @regions = Region.all
    
    render :json => @regions
  end
  
  def get_region 
    @region = Region.find(params[:id])
    @affiliates = @region.affiliates
    
    render :json => [region: @region, affiliates: @affiliates]
  end
  
  def get_cities
    @cities = Affiliate.uniq.pluck(:city)
    
    render :json => @cities
  end
  
  def get_countries
    @countries = Affiliate.uniq.pluck(:country)
    
    render :json => @countries    
  end
  
  def get_all_affiliates
    @affiliates = Affiliate.all
    render :json => @affiliates
  end
  
  def get_affiliates_by_country
    @affiliates = Affiliate.where(:country => params[:country])
    
    render :json => @affiliates
  end
  
  def get_affiliates_by_region
    @region = Region.find(params[:id])
    @affiliates = @region.affiliates
    
    render :json => @affiliates
  end
  
  def get_affiliates_by_city
    @affiliates = Affiliate.where(:city => params[:city])
    
    render :json => @affiliates
  end
  
  def get_affiliate
    @affiliate = Affiliate.find(params[:id])
    render :json => @affiliate
  end
end
