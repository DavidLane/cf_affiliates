class AddPostcodeToAaffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :postcode, :string
  end
end
