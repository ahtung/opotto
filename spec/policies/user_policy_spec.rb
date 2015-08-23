require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:stranger) { create(:user) }

  permissions :show? do
    it 'allows access to self' do
      expect(subject).to permit(user, user)
    end

    it 'denies access to guests' do
      expect(subject).not_to permit(nil, user)
    end

    it 'denies access to strangers' do
      expect(subject).not_to permit(nil, stranger)
    end
  end
end
