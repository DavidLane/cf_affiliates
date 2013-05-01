class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.column :title, :string
      
      t.timestamps
    end
  end
end
