class CreateNewAffiliateRequests < ActiveRecord::Migration
  def change
    create_table :new_affiliate_requests do |t|

      t.timestamps
    end
  end
end
