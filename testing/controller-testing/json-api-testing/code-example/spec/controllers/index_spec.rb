require 'spec_helper'
require_relative '../factories.rb'

describe "api_controller" do
  before do 
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end

  describe "get '/api/v1/users'" do
    before do
      5.times { FactoryGirl.create(:user) }
      get "/api/v1/users"
    end

    it "returns all users as json" do
      expect(last_response.body).to eq(User.all.to_json)
    end
  end

  describe "get '/api/v1/users/:user_id/articles'" do
    before do
      @user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:article, user: @user) }
      get "/api/v1/users/#{@user.id}/articles"
    end

    it "returns all articles belonging to specifed user, as json" do
      expect(last_response.body).to eq(@user.articles.to_json)
    end
  end

  describe "post '/api/v1/articles/:article_id/comments'" do
    context "with valid params" do
      before do
        @article = FactoryGirl.create(:article)
        commentor = FactoryGirl.create(:user)
        @valid_comment_params = { body: Faker::Lorem.sentence, user_id: commentor.id}
        post "/api/v1/articles/#{@article.id}/comments", @valid_comment_params
        @comment = Comment.find_by(@valid_comment_params)
      end

      it "creates a new comment with specified params" do
        expect(@comment).to be_truthy
      end

      it "returns the new comment, as json" do
        expect(last_response.body).to eq(@comment.to_json)
      end
    end

    context "with invalid params" do
      before do
        @article = FactoryGirl.create(:article)
        post "/api/v1/articles/#{@article.id}/comments", { water: false }
      end

      it "does not create a new comment" do
        expect(Comment.all.length).to eq(0)
      end

      it "returns status code 400" do
        expect(last_response.status).to eq(400)
      end

      it "returns an error message" do
        expect(last_response.body).to include("errors")
      end
    end
  end
end