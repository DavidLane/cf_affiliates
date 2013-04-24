class ChangeCerticateIdToCertificationId < ActiveRecord::Migration
  def change
		rename_column :affiliate_certifications, :certificate_id, :certification_id
  end
end
