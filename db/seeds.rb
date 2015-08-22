User.delete_all
Jar.delete_all

onur = FactoryGirl.create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR')
dunya = FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com', password: '123QwETR')
us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

onur.friends << [dunya, us]
dunya.friends << [onur, us]

FactoryGirl.create_list(:jar, 3, :with_contributions, owner: onur, guests: [dunya] + FactoryGirl.create_list(:user, 3), visible: true)
