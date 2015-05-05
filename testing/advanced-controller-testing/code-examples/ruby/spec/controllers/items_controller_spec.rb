require 'spec_helper'

describe "Items Controller" do

  describe "get /" do

    before(:all) do
      get '/'
    end

    it "returns an HTTP status of 302" do
      expect(last_response.status).to eq(302)
    end

    it "redirects to /items" do
      expect(last_response.location).to include('/items')
    end

  end

  describe "get /items" do

    let(:item) { Item.create  }

    before(:all) do
      10.times { }
      get '/items'
    end

  end


end