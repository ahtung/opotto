User.delete_all
Jar.delete_all

paypal = FactoryGirl.create(:user, email: 'paypal@opotto.com', password: '123QwETR')
onur = FactoryGirl.create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR')
dunya = FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com', password: '123QwETR')
us = FactoryGirl.create(:user, :with_paypal, password: '123QwETR')

onur.friends << [dunya, us, paypal]
dunya.friends << [onur, us, paypal]

# Random Jars
FactoryGirl.create_list(:jar, 3, :with_contributions, owner: onur, guests: [dunya] + FactoryGirl.create_list(:user, 3), visible: true)

# PayPal's test jar
FactoryGirl.create(:jar, name: 'PayPal test Jar',  owner: dunya, guests: [dunya, onur, paypal], visible: true)
