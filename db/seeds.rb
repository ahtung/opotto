if Rails.env.development?
  User.delete_all
  Jar.delete_all
  Friendship.delete_all
  Invitation.delete_all
  Contribution.delete_all

  onur = FactoryGirl.create(:user, :admin, email: 'onurkucukkece@gmail.com', password: '123QwETR')
  dunya = FactoryGirl.create(:user, :admin, email: 'dunyakirkali@gmail.com', password: '123QwETR')
  ilana = FactoryGirl.create(:user, :admin, email: 'contact@madco.nl', password: '123QwETR')
  us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

  onur.friends << [dunya, us, ilana]
  dunya.friends << [onur, us, ilana]
  ilana.friends << [dunya, onur, us]

  # Random Jars
  FactoryGirl.create_list(:jar, 3, :with_contributions, owner: onur, guests: [dunya] + FactoryGirl.create_list(:user, 3), visible: true)
elsif Rails.env.production?
  Jar.where(name: 'PayPal test Jar').destroy_all
  onur = User.where(email: 'onurkucukkece@gmail.com').first_or_create
  dunya = User.where(email: 'dunyakirkali@gmail.com').first_or_create
  ilana = User.where(email: 'contact@madco.nl').first_or_create
  paypal = User.where(email: 'paypal@opotto.com').first_or_create
  receiver = User.where(email: 'opotto-p-receiver@gmail.com').first_or_create
  FactoryGirl.create(:jar, name: 'PayPal test Jar',  owner: dunya, guests: [dunya, onur, paypal, ilana], visible: true, receiver: receiver)
end
