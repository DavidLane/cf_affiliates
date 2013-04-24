class CreateAffiliateCertifications < ActiveRecord::Migration
  def change
    create_table :affiliate_certifications do |t|

      t.timestamps
    end
  end
end
