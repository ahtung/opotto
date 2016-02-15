# Application Mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'info@ahtung.co'
  layout 'mailer'
end
