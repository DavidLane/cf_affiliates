class AddZoomToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :zoom, :integer
  end
end
