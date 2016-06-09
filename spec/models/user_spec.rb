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
      let(:user) { create(:user) }

      it 'should return nil if no access_token' do
        expect(user.import_contacts).to be_nil
      end
    end

    describe 'handle' do
      it 'returns name if user has name' do
        user = create(:user, name: 'DUN')
        expect(user.handle).to eq(user.name)
      end

      it 'returns email if user has no name' do
        user = create(:user)
        expect(user.handle).to eq(user.email)
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
        expect { User.find_for_google_oauth2(omniauth_hash(user.email), nil) }.to change { User.count }.by(1)
      end

      it 'should return user if exists' do
        user = create(:user)
        expect(User.find_for_google_oauth2(omniauth_hash(user.email), nil)).to eq(user)
      end
    end
  end
end
