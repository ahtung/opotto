require 'rails_helper'

describe Contribution do
  it { should belong_to(:user) }
  it { should belong_to(:jar) }
  it { should monetize(:amount_cents) }
end
