require 'rails_helper'

RSpec.describe Invitation, type: :model do
  # Relations
  it { should belong_to(:jar) }
  it { should belong_to(:user) }

  # DB
  it { should have_db_index(:user_id) }
  it { should have_db_index(:jar_id) }

  it '#invite_user' do
    invitation = create(:invitation)
    expect { invitation.invite_user }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
