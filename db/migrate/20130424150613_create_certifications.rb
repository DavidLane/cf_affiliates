class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.timestamps
    end
  end
end
