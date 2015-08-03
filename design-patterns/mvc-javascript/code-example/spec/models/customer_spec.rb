require "spec_helper"

RSpec.describe Customer do
  it { should have_many(:notes) }
  it { should validate_presence_of(:name) }
end
