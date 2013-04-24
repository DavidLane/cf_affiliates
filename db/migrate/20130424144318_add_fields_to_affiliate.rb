class AddFieldsToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :coords_lat, :string    
		add_column :affiliates, :coords_long, :string
    add_column :affiliates, :contact_name, :string		
		add_column :affiliates, :contact_number, :string
		add_column :affiliates, :contact_email, :string
  end
end
