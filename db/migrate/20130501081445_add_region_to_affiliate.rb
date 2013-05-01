class AddRegionToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :region, :string
  end
end
