require 'rails_helper'

describe ContributionPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:stranger) { create(:user) }
  let(:contribution) { create(:contribution, user: user) }

  permissions :success? do
    it 'allows access to owner' do
      expect(subject).to permit(user, contribution)
    end

    it 'denies access to users' do
      expect(subject).not_to permit(stranger, contribution)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(nil, contribution)
    end
  end

  permissions :failure? do
    it 'allows access to owner' do
      expect(subject).to permit(user, contribution)
    end

    it 'denies access to users' do
      expect(subject).not_to permit(stranger, contribution)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(nil, contribution)
    end
  end
end
