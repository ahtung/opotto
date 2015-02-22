require 'rails_helper'

describe JarPolicy do
  subject { described_class }

  permissions :update? do
    xit 'denies access if jar is closed' do
      # expect(subject).not_to permit(User.new(:admin => false), Post.new(:published => true))
    end

    xit 'denies access if user is not owner' do
      # expect(subject).to permit(User.new(:admin => true), Post.new(:published => true))
    end

    # xit "grants access if post is unpublished" do
    #   expect(subject).to permit(User.new(:admin => false), Post.new(:published => false))
    # end
  end
end