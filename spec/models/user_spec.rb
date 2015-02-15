require 'rails_helper'

describe User do
  it { should have_many(:jars).dependent(:destroy) }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributed_jars).through(:contributions).class_name('Jar') }
  it { should have_many(:invitations).dependent(:destroy) }
  it { should have_many(:invited_jars).through(:invitations).class_name('Jar') }
  it { should have_many(:friendships) }
  it { should have_many(:contacts).through(:friendships).class_name('User') }

  it '#uncontributed_jars' do
    user = create(:user, :with_jars)
    expect(user.uncontributed_jars).to eq(user.jars - user.contributed_jars)
  end
end
