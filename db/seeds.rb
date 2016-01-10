if Rails.env.development? || Rails.env.staging?
  User.delete_all
  Jar.delete_all

  onur = FactoryGirl.create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR')
  dunya = FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com', password: '123QwETR')
  us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

  onur.friends << [dunya, us]
  dunya.friends << [onur, us]

  # Random Jars
  FactoryGirl.create_list(:jar, 3, :with_contributions, owner: onur, guests: [dunya] + FactoryGirl.create_list(:user, 3), visible: true)
elsif Rails.env.production?
  Jar.where(name: 'PayPal test Jar').destroy_all
  onur = User.find_by(email: 'onurkucukkece@gmail.com')
  dunya = User.find_by(email: 'dunyakirkali@gmail.com')
  paypal = User.find_by(email: 'paypal@opotto.com')
  FactoryGirl.create(:jar, name: 'PayPal test Jar',  owner: dunya, guests: [dunya, onur, paypal], visible: true)
end
