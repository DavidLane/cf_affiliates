class AddOriginalScrapeDataToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :original_scrape_data, :text
  end
end
