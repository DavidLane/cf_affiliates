class AddHqTimestampToScrape < ActiveRecord::Migration
  def change
    add_column :scrapes, :hq_timestamp, :string
  end
end
