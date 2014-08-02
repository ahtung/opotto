
FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com', password: 'dE3kI812', password_confirmation: 'dE3kI812')
FactoryGirl.create_list(:user, 5, :with_jars, :with_contributions)