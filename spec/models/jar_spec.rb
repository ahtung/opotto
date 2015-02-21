require 'rails_helper'

describe Jar do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributors).through(:contributions).class_name('User') }

  it { should have_many(:invitations) }
  it { should have_many(:guests).through(:invitations).class_name('User') }

  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it '#total_contribution' do
    jar = create(:jar, :with_contributions)
    expect(jar.total_contribution).to eq jar.contributions.map(&:amount).inject { |sum, x| sum + x }
  end

  it '#total_contributors' do
    jar = create(:jar, :with_contributions)
    expect(jar.total_contributors).to eq jar.contributors.count
  end

  it '#total_guests' do
    jar = create(:jar, :with_guests)
    expect(jar.total_guests).to eq jar.guests.count
  end
end
