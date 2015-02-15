require 'rails_helper'

describe User do
  it { should have_many(:jars).dependent(:destroy) }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributed_jars).through(:contributions).class_name('Jar') }

  it '#uncontributed_jars' do
    user = create(:user, :with_jars)
    expect(user.uncontributed_jars).to eq(user.jars - user.contributed_jars)
  end

  describe '.find_for_google_oauth2' do
    it 'should create a new user if does not exist' do
      user = build(:user)
      expect{ User.find_for_google_oauth2(omniauth_hash(user.email, user.password), nil) }.to change{User.count}.by(1)
    end

    it "should return user if exists" do
      user = create(:user)
      expect(User.find_for_google_oauth2(omniauth_hash(user.email, user.password), nil)).to eq(user)
    end
  end
end
