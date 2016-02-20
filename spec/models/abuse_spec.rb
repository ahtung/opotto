require 'rails_helper'

RSpec.describe Abuse, type: :model do

  it { should belong_to(:resource) }

  describe 'confirm!' do
    let(:abuse) { build(:abuse) }

    it 'should set confirmed to true' do
      abuse.save
      abuse.confirm!
      expect(abuse.confirmed?).to be(true)
    end

    it 'should not set confirmed if new_record?' do
      abuse.confirm!
      abuse.restore_attributes([:confirmed])
      expect(abuse.confirmed?).to be(false)
    end
  end
end
