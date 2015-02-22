require 'rails_helper'

describe JarPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:jar) { create(:jar, owner: user, guests: [guest]) }

  permissions :show? do
    it 'allows access to members' do
      expect(subject).to permit(user, jar)
    end

    it 'allows access to non members' do
      expect(subject).to permit(nil, jar)
    end
  end

  permissions :new? do
    it 'allows access to members' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :create? do
    it 'allows access to members' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :edit? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :update? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end

  permissions :contribute? do
    it 'allows access to owner' do
      expect(subject).to permit(user, jar)
    end

    it 'allows access to guests' do
      expect(subject).to permit(guest, jar)
    end

    it 'denies access to members' do
      expect(subject).not_to permit(create(:user), jar)
    end

    it 'denies access to non members' do
      expect(subject).not_to permit(nil, jar)
    end
  end
end