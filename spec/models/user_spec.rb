require 'rails_helper'

describe User do
  it { should have_many(:pots).dependent(:destroy) }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributed_pots).through(:contributions).class_name('Pot') }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:invited_pots).through(:invitations).class_name('Pot') }
  it { should have_many(:friendships) }
  it { should have_many(:friends).through(:friendships) }
  it { should have_many(:inverse_friendships).class_name('Friendship') }
  it { should have_many(:inverse_friends).through(:inverse_friendships).source(:user) }

  describe '#' do
    describe 'batch_import_contacts' do
      it 'should batch import_contacts' do
        user = create(:user)
        contact_details = attributes_for(:user)
        user.batch_import_contacts([contact_details])
        user.reload
        expect(user.friends.count).to eq(1)
      end
    end

    describe 'name?' do
      it 'should return true if user has both name and surname' do
        user = create(:user)
        expect(user.name?).to eq(true)
      end

      it 'should return false if user has no name or surname' do
        user = create(:user, first_name: nil)
        expect(user.name?).to eq(false)
      end
    end

    describe 'access_token' do
      let(:user) { create(:user) }

      it 'should return nil if no refresh_token' do
        expect(user.access_token).to be_nil
      end

      xit 'should return access_token if refresh_token' do
        user.refresh_token = 'TOKEN'
        expect(user.access_token).not_to be_nil
      end
    end

    describe 'import_contacts' do
      it 'should return nil if no access_token' do
        user = create(:user)
        expect(user.import_contacts).to be_nil
      end

      xit 'should return true if contacts are imported' do
        mash = Hashie::Mash.new(mock_auth_hash)
        google_user = User.find_for_google_oauth2(mash)
        puts google_user.inspect
        expect(google_user.import_contacts).not_to be_nil
      end
    end

    describe 'uncontributed_pots' do
      it 'should return user.pots - user.contributed_pots' do
        user = create(:user, :with_pots)
        expect(user.uncontributed_pots).to eq(user.pots - user.contributed_pots)
      end
    end

    describe 'iscoverable_pots' do
      it 'should return user.pots - user.contributed_pots' do
        user = create(:user, :with_pots)
        expect(user.discoverable_pots).to eq(Pot.visible - user.pots - user.invited_pots)
      end
    end
  end

  describe '.' do
    describe 'admin' do
      let(:admin) { create(:user, :admin) }
      let(:user) { create(:user) }

      it 'returns admins' do
        expect(User.admin).to include(admin)
      end

      it 'does not return regular users' do
        expect(User.admin).not_to include(user)
      end
    end

    describe 'find_for_google_oauth2' do
      it 'should create a new user if does not exist' do
        user = build(:user)
        expect do
          User.find_for_google_oauth2(omniauth_hash(user.email), nil)
        end.to change { User.count }.by(1)
      end

      it 'should return user if exists' do
        user = create(:user)
        expect(User.find_for_google_oauth2(omniauth_hash(user.email), nil)).to eq(user)
      end
    end
  end
end
