# JarMailer
class JarMailer < ActionMailer::Base
  default from: 'info@opotto.com'
  layout 'mailer'

  def scheduled_email(contribution)
    @contribution = contribution
    @user = @contribution.user
    @jar = contribution.jar
    mail(subject: 'Your contribution sucessfully scheduled!', to: @user.email)
  end

  def completed_email(contribution)
    @contribution = contribution
    @user = @contribution.user
    @jar = contribution.jar
    mail(subject: 'You have sucessfully contributed!', to: @user.email)
  end
end
