require 'spec_helper'

describe "ItemsController" do

  describe "GET /items" do

    before(:all) do
      @item = Item.create(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(1..100))
      get '/items'
    end

    it "has http status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the items index page" do
      expect(last_response.body).to include("<h1>Items Page</h1>")
    end

    it "renders all items on the page" do
      expect(last_response.body).to include(@item.description)
    end

    after(:all) do
      Item.destroy_all
    end

  end

  describe "POST /items" do

    describe "if valid request" do

      before(:all) do
        @params = { name: Faker::Commerce.product_name, price: rand(1..100), description: Faker::Lorem.sentence }
        post '/items', @params
      end

      it "returns http status code of 302" do
        expect(last_response.status).to eq(302)
      end

      it "creates an item in the database" do
        expect(Item.find_by_name(@params[:name])).to be_truthy
      end

      it "redirects to /items" do
        expect(last_response.location).to include('/items')
      end

      after(:all) do
        Item.destroy_all
      end

    end

    describe "if invalid request" do

      before(:all) do
        @params = { price: rand(1..100), description: Faker::Lorem.sentence }
        post '/items', @params
      end

      it "returns http status code of 302" do
        expect(last_response.status).to eq(302)
      end

      it "does not create an item in the database" do
        expect(Item.find_by_name(@params[:name])).to be_nil
      end

      it "redirects to /items" do
        expect(last_response.location).to include('/items')
      end

      after(:all) do
        Item.destroy_all
      end

    end


  end

end