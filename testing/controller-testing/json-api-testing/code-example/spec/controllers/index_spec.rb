require 'spec_helper'
require_relative '../factories.rb'

describe "IndexController" do

  before do
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end

  describe "GET /api/v1/users" do

    before do
      5.times { FactoryGirl.create(:user) }
      get "/api/v1/users"
    end

    it "should return all the users as json" do
      expect(last_response.body).to eq(User.all.to_json)
    end

  end

  describe "GET /api/v1/users/:id/articles" do

    before do
      @user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:article, user: @user)}
      get "/api/v1/users/#{@user.id}/articles"
    end

    it "should return all articles of user with specified id as json" do
      expect(last_response.body).to eq(@user.articles.to_json)
    end

  end

  describe "POST /api/v1/articles/:id/comments" do

    context "if we make a valid request" do

      before do
        @article = FactoryGirl.create(:article)
        @valid_params = FactoryGirl.attributes_for(:comment)
        post "/api/v1/articles/#{@article.id}/comments", @valid_params
      end

      it "should create a comment for article with specified id" do
        expect(@article.comments.find_by(@valid_params)).to be_truthy
      end

      it "returns created comment as json" do
        expect(last_response.body).to eq(@article.comments.find_by(@valid_params).to_json )
      end

    end

    context "if we make an invalid request" do

      before do
        @article = FactoryGirl.create(:article)
        post "/api/v1/articles/#{@article.id}/comments", { water: true }
      end

      it "shouldn't create a comment at all" do
        expect(Comment.all.length).to eq(0)
      end

      it "should return http status of 400" do
        expect(last_response.status).to eq(400)
      end

    end

  end

end