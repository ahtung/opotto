require 'rails_helper'

RSpec.describe Friendship, type: :model do
  # Relations
  it { should belong_to(:user) }
  it { should belong_to(:friend).class_name('User') }

  # DB
  it { should have_db_index(:user_id) }
  it { should have_db_index(:friend_id) }
end
