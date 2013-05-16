class AffiliateUpdateRequestMailer < ActionMailer::Base
  default :to => AdminUser.all.map(&:email),
          :from => "alert@cfuk-affiliates.com"
  
  def new_request_added(affiliate_request)
    @affiliate_request = affiliate_request
    mail(:subject => "New Affiliate Request")
  end  
end
