require 'rails_helper'

RSpec.describe CatsController, type: :controller do

    describe "#index" do

        before do 
            5.times { create(:cat) }
            get :index
        end

        it { should respond_with(200) }
        it { should render_template(:index) }
        it "should assign @cats to all Cats in DB" do
          expect(assigns(:cats)).to eq(Cat.all)
        end

    end

    describe "#show" do

        before do
            @cat = create(:cat)
            get :show, id: @cat.id
        end

        it { should respond_with(200) }
        it { should render_template(:show) }
        it "should assign cat with specified id to @cat" do
            expect(assigns(:cat)).to eq(@cat)
        end
        it "should call cat's #lose_a_life! method" do
          @cat.reload
          expect(@cat.lives).to eq(8)
        end

    end

    describe "#new" do

       before do
         get :new
       end

       it { should respond_with(200) }
       it { should render_template(:new) }
       it "assigns an instance of Cat to @cat" do
        expect(assigns(:cat)).to be_a(Cat)
      end

    end

    describe "#create" do

       context "if valid params" do

         before do
           @cat_params = attributes_for(:cat)
           post :create, { cat: @cat_params }
         end

         it { should respond_with(302) }
         it "should redirect to the new cat's page" do
           cat = Cat.find_by(@cat_params)
           expect(response).to redirect_to("/cats/#{cat.id}")
         end
         it "creates a new cat with specified params" do
           expect(Cat.find_by(@valid_params)).to be_truthy
         end

       end

       context "if invalid params" do

         before do 
           post :create, { cat: {name: "test"} }
         end

         it { should respond_with(400) }
         it { should render_template(:new) }
         it "should not create a new cat" do
           expect(Cat.find_by_name("test")).to be_nil
         end

       end

     end

     describe "#edit" do

       before do
         @cat = create(:cat)
         get :edit, id: @cat.id
       end

       it { should respond_with(200) }
       it { should render_template(:edit) }
       it "should assign cat with specified id to @cat" do
         expect(assigns(:cat)).to eq(@cat)
       end

     end

     describe "#update" do

         context "with valid params" do

           before do
             @cat = create(:cat)
             @cat_params = attributes_for(:cat) # new info for the
             patch :update, { id: @cat.id, cat: @cat_params }
           end

           it { should respond_with(302) }
           it { should redirect_to("/cats/#{@cat.id}")}
           it "should update the attributes for cat" do
             expect(Cat.find_by(@cat_params)).to be_truthy
           end

         end

         context "with invalid params" do

           before do
             @cat = create(:cat)
             @invalid_cat_params = { name: "", life_story: "", image_url: "" }
             patch :update, { id: @cat.id, cat: @invalid_cat_params }
           end

           it { should respond_with(400) }
           it { should render_template(:edit) }
           it "should not update the attributes for cat" do
             expect(Cat.find_by(@invalid_cat_params)).to be_nil
           end

         end

       end
end