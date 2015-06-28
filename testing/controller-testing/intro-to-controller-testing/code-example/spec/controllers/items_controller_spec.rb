require 'spec_helper'

describe "ItemsController" do

  let(:valid_params) { { name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(1..100) } }
  let(:invalid_params) { { price: rand(1..100), description: Faker::Lorem.sentence } }

  describe "GET /items" do

    context "if no error stored in the session" do

      before do
        @item = Item.create(valid_params)
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

    end

    context "if error in the session" do

      before do
        @item = Item.create(valid_params)
        get '/items', {}, "rack.session" => {:error => "meowmeow"}
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

      it "renders error message on the page" do
        expect(last_response.body).to include("meowmeow")
      end

      it "clears the session of errors" do
        expect(session[:error]).to be_nil
      end

    end

  end

  describe "POST /items" do

    context "if valid request" do

      before do
        post '/items', valid_params
      end

      it "returns http status code of 302" do
        expect(last_response.status).to eq(302)
      end

      it "creates an item in the database with specified params" do
        expect(Item.find_by_name(valid_params[:name])).to be_truthy
      end

      it "redirects to /items" do
        full_url = last_response.original_headers["Location"]
        expect(URI(full_url).path).to eq('/items')
      end

    end

    context "if invalid request" do

      before do
        post '/items', invalid_params
      end

      it "returns http status code of 302" do
        expect(last_response.status).to eq(302)
      end

      it "does not create an item in the database with specified params" do
        expect(Item.find_by_name(invalid_params[:name])).to be_nil
      end

      it "redirects to /items" do
        full_url = last_response.original_headers["Location"]
        expect(URI(full_url).path).to eq('/items')
      end

      it "stores error in the session" do
        expect(session[:error]).to be_truthy
      end

    end

  end

  after do
    Item.destroy_all
  end

end