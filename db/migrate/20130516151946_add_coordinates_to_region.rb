class AddCoordinatesToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :coords_lat, :string
    add_column :regions, :coords_long, :string
  end
end
