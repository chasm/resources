require 'spec_helper'

describe 'ApiController' do

  describe 'GET /api/items' do

    before(:all) do
      @item = Item.create(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(1..100))
      get '/api/items'
      @json_response = JSON.parse(last_response.body)
    end

    it "returns an http status of 200" do
      expect(last_response.status).to eq(200)
    end

    it "returns a json representation of the item objects" do
      mock_response = [
        {
          "id" => @item.id,
          "name" => @item.name,
          "price" => @item.price,
          "description" => @item.description
        }
      ]
      expect(@json_response).to eq(mock_response)
    end

    after(:all) do
      Item.destroy_all
    end

  end

  describe "POST /api/items" do

    describe "without valid params" do

      before(:all) do
        post '/api/items'
      end

      it "returns http status 400" do
        expect(last_response.status).to eq(400)
      end

      it "does not add an item to the database" do
        expect(Item.count).to eq(0)
      end

      after(:all) do
        Item.destroy_all
      end

    end

    describe "with valid params" do

      before(:all) do
        @params = { name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(1..100) }
        post '/api/items', @params
        @item = Item.find_by(description: @params[:description])
        @json_response = JSON.parse(last_response.body)
      end

      it "returns http status 200" do
        expect(last_response.status).to eq(200)
      end

      it "adds new item to the database" do
        expect(@item).to be_truthy
      end

      it "returns a json representation of an item" do
        mock_response = {
                           "id" => @item.id,
                           "name" => @item.name,
                           "description" => @item.description,
                           "price" => @item.price
                         }
        expect(@json_response).to eq(mock_response)
      end

    end

  end

end
