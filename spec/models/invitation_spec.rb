require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { should belong_to(:jar) }
  it { should belong_to(:user) }

  it '#invite_user' do
    invitation = create(:invitation)
    expect{ invitation.invite_user }.to change{ ActionMailer::Base.deliveries.count }.by(1)
  end
end
