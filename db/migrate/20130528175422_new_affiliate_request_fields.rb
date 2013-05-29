class NewAffiliateRequestFields < ActiveRecord::Migration
  def change
    add_column :new_affiliate_requests, :requester_email, :string
    add_column :new_affiliate_requests, :title, :string
    add_column :new_affiliate_requests, :contact_name, :string    
    add_column :new_affiliate_requests, :contact_number, :string
    add_column :new_affiliate_requests, :contact_email, :string
    add_column :new_affiliate_requests, :website, :string
    add_column :new_affiliate_requests, :address, :string
    add_column :new_affiliate_requests, :postcode, :string
    add_column :new_affiliate_requests, :city, :string    
  end
end
