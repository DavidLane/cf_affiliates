class AddThroughForAffiliateCertification < ActiveRecord::Migration
  def change
		add_column :affiliate_certifications, :affiliate_id, :integer
    add_column :affiliate_certifications, :certificat_id, :integer
  end
end
