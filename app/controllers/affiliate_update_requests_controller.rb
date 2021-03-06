class AffiliateUpdateRequestsController < ApplicationController
  def new
    @affiliate = Affiliate.find(params[:affiliate_id]);
    @affiliate_update_request = @affiliate.affiliate_update_requests.build
    
    @affiliate_update_request.populate_from_affiliate(@affiliate)

    render :layout => false
  end
  
  def create
    @affiliate_update_request = AffiliateUpdateRequest.new(params[:affiliate_update_request]);
    @affiliate = Affiliate.find(params[:affiliate_update_request][:affiliate_id])
    
    respond_to do |format|
      unless @affiliate_update_request.save
        format.js { render "index" }
      else
        flash[:affiliate_box_notice] = "Your update has been received. Thanks!"
        format.js { render 'completed' }
      end
    end
  end
end
