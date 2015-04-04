require 'rails_helper'

describe User do
  it { should have_many(:jars).dependent(:destroy) }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributed_jars).through(:contributions).class_name('Jar') }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:invited_jars).through(:invitations).class_name('Jar') }
  it { should have_many(:friendships) }
  it { should have_many(:friends).through(:friendships) }
  it { should have_many(:inverse_friendships).class_name('Friendship') }
  it { should have_many(:inverse_friends).through(:inverse_friendships).source(:user) }

  describe '#' do
    describe '#handle' do
      it 'returns name if user has name' do
        user = create(:user, name: 'DUN')
        expect(user.handle).to eq(user.name)
      end

      it 'returns email if user has no name' do
        user = create(:user)
        expect(user.handle).to eq(user.email)
      end
    end

    it 'uncontributed_jars' do
      user = create(:user, :with_jars)
      expect(user.uncontributed_jars).to eq(user.jars - user.contributed_jars)
    end
  end

  describe '.' do
    describe 'with_paypal_account' do
      let(:users_with) { create_list(:user, 2, paypal_member: true) }
      let(:users_without) { create_list(:user, 2, paypal_member: false) }

      it "returns user's w/ a paypal account" do
        expect(User.with_paypal_account).to match_array(users_with)
      end

      it "does not return user's w/o a paypal account" do
        expect(User.with_paypal_account).not_to match_array(users_without)
      end
    end
  end

  describe '.find_for_google_oauth2' do
    it 'should create a new user if does not exist' do
      user = build(:user)
      expect { User.find_for_google_oauth2(omniauth_hash(user.email), nil) }.to change { User.count }.by(1)
    end

    it 'should return user if exists' do
      user = create(:user)
      expect(User.find_for_google_oauth2(omniauth_hash(user.email), nil)).to eq(user)
    end
  end

  describe '#schedule_import_contacts' do
    let(:user) { create(:user) }

    it 'should schedule import contacts on update' do
      expect { FriendSyncWorker.perform_async(user.id) }.to change(FriendSyncWorker.jobs, :size).by(1)
    end

    it 'should not schedule import contacts on create' do
      expect(FriendSyncWorker.jobs.size).to eq 0
    end
  end

  describe '#access_token' do
    let(:user) { create(:user) }

    it 'should return nil if no refresh_token' do
      expect(user.access_token).to be_nil
    end
  end

  describe '#import_contacts' do
    let(:user) { create(:user) }

    it 'should return nil if no access_token' do
      expect(user.import_contacts).to be_nil
    end
  end

  describe '.paypal_account?' do
    describe 'for a user with paypal account' do
      let(:user) { create(:user, :with_paypal) }

      it 'should return true if email has paypal account' do
        expect(User.paypal_account?(user.email)).to be true
      end
    end

    describe 'for a user with no paypal account' do
      let(:user) { create(:user) }

      it 'should return false if email has no paypal account' do
        expect(User.paypal_account?(user.email)).to be false
      end
    end
  end
end
