FactoryGirl.create(:user, :with_jars, :with_contributions, email: 'dunyakirkali@gmail.com')
FactoryGirl.create_list(:user, 3, :with_jars, :with_contributions)