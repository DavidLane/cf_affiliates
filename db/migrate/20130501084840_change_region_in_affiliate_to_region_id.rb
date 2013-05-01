class ChangeRegionInAffiliateToRegionId < ActiveRecord::Migration
  def change
		rename_column :affiliates, :region, :region_id
  end
end
