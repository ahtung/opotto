require 'rails_helper'

describe 'User' do
  let!(:user) { FactoryGirl.create(:user) }
  
  before :each do
    login user
  end
  
  it 'should be able to create a new jar' do
    visit root_path
    click_on 'New jar'
    fill_in 'jar_name', with: 'Joelle getting married'    
    click_on 'Save'
    
    expect(page).to have_content('Jar was successfully created.')
  end
end