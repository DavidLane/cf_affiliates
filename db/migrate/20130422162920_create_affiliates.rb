class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.column :title, :string
      t.column :website, :string
      t.column :city, :string
      t.column :state, :string
      t.column :country, :string
      t.timestamps
    end
  end
end
