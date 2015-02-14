require 'rails_helper'

describe Jar do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:contributions).dependent(:destroy) }
  it { should have_many(:contributors).through(:contributions).class_name('User') }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it '#total_contribution' do
    jar = create(:jar, :with_contributions)
    expect(jar.total_contribution).to eq (jar.contributions.sum('amount') / 100).to_f
  end

  it '#total_contributors' do
    jar = create(:jar, :with_contributors)
    expect(jar.total_contributors).to eq jar.contributors.count
  end
end
