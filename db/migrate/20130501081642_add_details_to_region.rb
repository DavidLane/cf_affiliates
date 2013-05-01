class AddDetailsToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :title, :string
  end
end
