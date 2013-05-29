class AddUnprocessedToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :unprocessed, :boolean
  end
end
