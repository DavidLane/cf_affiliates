class CreateScrapes < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.column :raw_html, :text
      t.timestamps
    end
  end
end
