require "spec_helper"

RSpec.describe Note do
  it { should belong_to(:customer) }
  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:content) }
end
