require 'rails_helper'

describe 'User should be able to' do

  let!(:user) { create(:user, :with_jars) }
  let!(:jar) { user.jars.first }

  before :each do
    login user
  end

  # Create
  describe 'create a jar' do
    before :each do
      click_on 'New jar'
    end

    context 'sucessfully' do

      before :each do
        fill_in 'jar_name', with: 'Joelle getting married'
        click_on 'Save'
      end

      it 'and see a notice' do
        expect(page).to have_content('Jar was successfully created.')
      end

      it 'and see the name' do
        expect(page).to have_content('Joelle getting married')
      end
    end

    context 'unsucessfully' do
      it 'and see an error' do
        click_on 'Save'

        expect(page).to have_content("Name can't be blank")
      end
    end

  end

  # Read
  describe 'read a jar' do

    before :each do
      first(:link, jar.name).click
    end

    context 'sucessfully' do
      it 'and the owner' do
        expect(page).to have_content("owned by #{jar.owner.email}")
      end
    end

    context 'unsucessfully' do
      it 'and see a ?404 page'
    end

  end


  # Update
  describe 'update a jar' do

    before :each do
      first(:link, jar.name).click
      click_on 'Edit'
    end

    context 'sucessfully' do
      it 'and see a notice' do
        fill_in 'jar_name', with: 'Joelle getting married'
        click_on 'Save'

        expect(page).to have_content('Jar was successfully updated.')
      end
    end

    context 'unsucessfully' do
    end

  end

  # Destroy
  describe 'destroy a jar' do

    before :each do
      first(:link, jar.name).click
      click_on 'Delete'
    end

    context 'sucessfully' do
      it 'and see a notice' do
        expect(page).to have_content('Jar was successfully destroyed.')
      end
    end

    context 'unsucessfully' do
      xit 'and see a alert' do
        expect(page).to have_content('Jar cannot be deleted.')
      end
    end

  end

  # Contribute
  describe 'contribute to a jar' do

    before :each do
      first(:link, jar.name).click
      click_on 'Contribute'
    end

    context 'sucessfully' do
      it 'and see a notice' do
        cont = build(:contribution)
        fill_in :contribution_amount, with: cont.amount
        click_on 'Save'
        expect(page).to have_content("Contribution was successfully created.")
      end
    end

    context 'unsucessfully' do
      xit 'and see a alert' do
        expect(page).to have_content('Something went wrong :S')
      end
    end

  end

end