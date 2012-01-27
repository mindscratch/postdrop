ActionMailer::Base.smtp_settings = {
  :address => ENV['POSTDROP_MAIL_HOST'],
  :port => ENV['POSTDROP_MAIL_PORT'],
  :domain => "codescratch.com",
  :user_name => ENV['POSTDROP_MAIL_USERNAME'],
  :password => ENV['POSTDROP_MAIL_PASSWORD'],
  :authentication => "plain"
}
