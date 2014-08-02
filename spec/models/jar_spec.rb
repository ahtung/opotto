require 'rails_helper'

describe Jar do
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:contributions) }
  it { should have_many(:contributors).through(:contributions).class_name('User') }
end
