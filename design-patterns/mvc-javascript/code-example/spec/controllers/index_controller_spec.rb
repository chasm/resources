require "spec_helper"

RSpec.describe "Index Controller" do

  describe "get /" do

    before { get "/" }

    it "returns an ok response" do
      expect(last_response).to be_ok
    end

    it "gives us a div to hang our dynamic content off of" do
      expect(last_response.body).to include('<div id="crm">')
    end

  end

end
