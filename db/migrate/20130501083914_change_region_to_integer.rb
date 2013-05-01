class ChangeRegionToInteger < ActiveRecord::Migration
  def change
		change_column :affiliates, :region, :integer
  end
end
