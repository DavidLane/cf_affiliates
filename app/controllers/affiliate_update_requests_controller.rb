class AffiliateUpdateRequestsController < ApplicationController
  def create
    @affiliate_update_request = AffiliateUpdateRequest.new(params[:affiliate_update_request]);
    @affiliate = Affiliate.find(params[:affiliate_update_request][:affiliate_id])
    
    unless @affiliate_update_request.save
      render :template => "affiliates/show"
    else
      flash[:notice] = "Your update has been received. Thanks!"
      redirect_to affiliate_path(@affiliate)
    end
  end
end
