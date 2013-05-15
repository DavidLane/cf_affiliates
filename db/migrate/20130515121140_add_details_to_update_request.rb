class AddDetailsToUpdateRequest < ActiveRecord::Migration
  def change
		add_column :affiliate_update_requests, :requester_email, :string
		add_column :affiliate_update_requests, :affiliate_id, :integer
		add_column :affiliate_update_requests, :new_title, :string
		add_column :affiliate_update_requests, :new_email, :string
    add_column :affiliate_update_requests, :new_telephone_number, :string		
    add_column :affiliate_update_requests, :new_address, :string
    add_column :affiliate_update_requests, :new_postcode, :string
    add_column :affiliate_update_requests, :new_website, :string
    add_column :affiliate_update_requests, :new_city, :string
    add_column :affiliate_update_requests, :region_id, :integer
  end
end
