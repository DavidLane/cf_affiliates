class ScraperMailer < ActionMailer::Base
  default :to => AdminUser.all.map(&:email),
          :from => "scraper@cfuk-affiliates.com"
  
  def new_affiliates_added(new_affiliates)
    @affiliates = new_affiliates
    mail(:subject => "New Affiliate Added")
  end
end
