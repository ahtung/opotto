require 'rails_helper'

describe Contribution do
  it { should belong_to(:user) }
  it { should belong_to(:jar) }
end
