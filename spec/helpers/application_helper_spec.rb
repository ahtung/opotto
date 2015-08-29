require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#phone_number_link" do
    it "returns phone number link" do
      phone_number = '90 312 284 31 48'
      expect(helper.phone_number_link(phone_number)).to eq('<a href="tel://+90-312-284-31-48">+90-312-284-31-48</a>')
    end
  end
end