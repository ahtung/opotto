# JarMailer
class JarMailer < ActionMailer::Base
  default from: 'info@ahtung.co'
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

  def failed_payment_email(contribution)
    @contribution = contribution
    @user = @contribution.user
    @jar = contribution.jar
    mail(subject: 'Your payment has failed', to: @user.email)
  end
end
