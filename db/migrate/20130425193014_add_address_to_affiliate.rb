class AddAddressToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :address, :string 
  end
end
