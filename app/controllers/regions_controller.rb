class RegionsController < ApplicationController
  def show
    @region = Region.find(params[:id])
    @affiliates = @region.affiliates
  end
end
