class ScraperMailer < ActionMailer::Base
  default :to => AdminUser.all.map(&:email),
          :from => "from@example.com"
  
  def new_affiliate_added(new_affiliates)
    @affiliates = new_affiliates
    mail(:subject => "New Affiliate Added")
  end
end
