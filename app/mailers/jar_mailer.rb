# JarMailer
class JarMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def scheduled_email(receiver, contribution)
    @receiver = receiver
    @contribution = contribution
    @jar = contribution.jar
    mail(subject: 'Your contribution sucessfully scheduled!', to: @receiver.email)
  end

  def completed_email(receiver, contribution)
    @receiver = receiver
    @contribution = contribution
    @jar = contribution.jar
    mail(subject: 'You have sucessfully contributed!', to: @receiver.email)
  end
end