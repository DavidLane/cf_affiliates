class CreateAffiliateUpdateRequests < ActiveRecord::Migration
  def change
    create_table :affiliate_update_requests do |t|

      t.timestamps
    end
  end
end
