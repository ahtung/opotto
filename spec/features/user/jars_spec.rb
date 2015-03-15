require 'rails_helper'

describe 'User should be able to', js: true, skip: true do

  let(:user) { nil }
  let!(:jar_mock) { build(:jar) }

  before :each do
    login_as user
    visit authenticated_root_path
  end

  # Create
  describe 'create a jar' do
    let(:user) { create(:user) }
    before :each do
      click_on t('jar.new')
    end

    context 'sucessfully' do

      before :each do
        first('#jar_name').set jar_mock.name
        first('#jar_end_at_date').set jar_mock.end_at
        first('#jar_end_at_time').set jar_mock.end_at
        first('#jar_visible').set jar_mock.visible
        select2 user.email, from: t('activerecord.attributes.jar.guest_ids')
        click_on t('jar.save')
      end

      it 'and see a notice' do
        expect(page).to have_content(t('jar.new'))
      end

      it 'and not to see the name' do
        expect(page).to have_content jar_mock.name
      end

      it 'and see the end_at' do
        expect(page).to have_content distance_of_time_in_words(Time.now, jar_mock.end_at)
      end

      it 'and invite guests' do
        user.reload
        expect(user.jars.last.guests.count).to eq(1)
      end
    end

    context 'unsucessfully' do
      it 'and see an error' do
        click_on t('jar.save')
        expect(page).to have_content t('activerecord.errors.models.jar.attributes.name.blank')
      end
    end

  end

  # Read
  describe 'read a jar' do
    let(:user) { create(:user, :with_jars) }
    before :each do
      first(:link, user.invited_jars.first.name).click
    end

    context 'sucessfully' do
      it 'and the owner' do
        expect(page).to have_content t('jar.owned_by', email: user.invited_jars.first.owner.email)
      end
    end

    context 'unsucessfully' do
      it 'and see a ?404 page' do
        jar = user.invited_jars.first
        jar.destroy
        visit jar_path(jar)
        expect(page).to have_content '404'
      end
    end

  end

  # Update
  describe 'update a jar' do
    let(:user) { create(:user, :with_jars) }
    before :each do
      visit edit_jar_path(user.jars.first)
    end

    context 'sucessfully' do
      it 'and see a notice' do
        fill_in 'jar_name', with: 'Joelle getting married'
        click_on t('jar.save')

        expect(page).to have_content(t('jar.updated'))
      end
    end

    context 'unsucessfully' do
    end

  end

  # Contribute
  describe 'contribute to a jar' do
    let(:user) { create(:user, :with_invitations) }
    before :each do
      first(:link, user.invited_jars.first.name).click
      click_on t('jar.contribute')
    end

    context 'anonymously' do
      before :each do
        cont = build(:contribution)
        fill_in :contribution_amount, with: cont.amount
        check('Anonymous')
        click_on t('jar.save')
        first(:link, user.invited_jars.first.name).click
      end

      it 'and have his email visible once as guest' do
        expect(page).to have_content(user.email, count: 1)
      end

      it 'and have his contribution listed as N/A' do
        expect(page).to have_content('N/A')
      end
    end

    describe 'should save an amount with a decimal value' do
      it 'only single digit' do
        total_contribution = user.invited_jars.first.total_contribution
        fill_in :contribution_amount, with: total_contribution + 5.5
        click_on t('jar.save')
        expect(page).to have_content("$#{total_contribution + 5.5}")
      end

      it 'with two digits' do
        total_contribution = user.invited_jars.first.total_contribution
        fill_in :contribution_amount, with: total_contribution + 5.99
        click_on t('jar.save')
        expect(page).to have_content("$#{total_contribution + 5.99}")
      end
    end

    context 'sucessfully' do
      it 'and see a notice' do
        cont = build(:contribution)
        fill_in :contribution_amount, with: cont.amount
        click_on t('jar.save')
        expect(page).to have_content(t('contribution.created', name: user.invited_jars.first.name, amount: number_to_currency(cont.amount)))
      end
    end

    context 'unsucessfully when amount is 0' do
      it 'and see a alert' do
        fill_in :contribution_amount, with: 0
        click_on t('jar.save')
        expect(page).to have_content t('activerecord.errors.models.contribution.attributes.amount.greater_than_or_equal_to')
      end
    end

  end

  # Contribute to a jar with upper_bound
  describe 'contribute to a jar witha an upper bound' do
    let(:user) { create(:user, :with_invitations) }
    before :each do
      @jar = FactoryGirl.create(:jar, :with_upper_bound, :public)
      visit jar_path(@jar)
      click_on t('jar.contribute')
    end

    it 'should save successfully if the amount is inside the bounds' do
      amount = Faker::Number.number(1)
      fill_in :contribution_amount, with: amount
      click_on t('jar.save')
      expect(page).to have_content(t('contribution.created', name: @jar.name, amount: number_to_currency(amount)))
    end

    it 'should railse an error if the amount is out of bounds' do
      amount = Faker::Number.number(3)
      fill_in :contribution_amount, with: amount
      click_on t('jar.save')
      expect(page).to have_content(t('activerecord.errors.models.contribution.attributes.amount.amount_out_of_bounds'))
    end
  end

end
