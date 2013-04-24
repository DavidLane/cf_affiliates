class AddDetailsToCertification < ActiveRecord::Migration
  def change
		add_column :certifications, :title, :string
  end
end
