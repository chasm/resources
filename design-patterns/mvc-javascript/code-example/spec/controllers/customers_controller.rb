require "spec_helper"

RSpec.describe "Customers Controller" do

  describe "get /customers" do

    it "returns an empty list if there are no customers" do
      allow(Customer).to receive(:all).and_return([])
      get "/customers"
      expect(last_json).to eq([])
    end

    describe "returns a list of customers in JSON" do

      let(:customer_1) { Customer.new(name: "Sam") }
      let(:customer_2) { Customer.new(name: "Darcy") }
      let(:customers) { [ customer_1, customer_2 ] }

      before do
        allow(Customer).to receive(:all).and_return(customers)
        get "/customers"
        @first_customer = last_json.first
      end

      it "returns an array" do
        expect(last_json).to be_a(Array)
      end

      it "returns all the customers" do
        expect(last_json.length).to eq(customers.length)
      end

      it "has the names for a name for a customer" do
        expect(@first_customer["name"]).to eq("Sam")
      end

    end

  end

  describe "post /customers" do

    let(:customer)         { Customer.new }
    let(:valid_params) { { "customer" => { "name" => "Sam" } } }

    it "passes the paramters to the new customer" do
      expect(Customer).to receive(:new).with(valid_params["customer"]).and_return(customer)
      post "/customers", valid_params
    end

    it "returns the customer data if saved successfully" do
      allow(customer).to receive(:save).and_return(true)
      post "/customers", valid_params
      customer_json = last_json["customer"]
      expect(customer_json["name"]).to eq("Sam")
    end

    it "responds with a bad request if not saved successfully" do
      allow(Customer).to receive(:new).and_return(customer)
      allow(customer).to receive(:save).and_return(false)
      post "/customers", valid_params
      expect(last_response).to be_bad_request
    end

  end

  describe "put /customers/:id" do

    let(:customer)         { Customer.new }
    let(:valid_params) { { "customer" => { "name" => "Sam" } } }

    it "finds the right customer" do
      expect(Customer).to receive(:find).with("8").and_return(customer)
      put "/customers/8", valid_params
    end

    it "updates the customer data" do
      expected_data = { "name" => "Sam" }
      allow(Customer).to receive(:find).and_return(customer)
      expect(customer).to receive(:update).with(expected_data)
      put "/customers/8", valid_params
    end

    it "returns update customer for a successful update" do
      allow(Customer).to receive(:find).and_return(customer)
      put "/customers/8", valid_params
      customer_json = last_json["customer"]
      expect(customer_json["name"]).to eq("Sam")
    end

    it "returns bad request for an unsuccessful update" do
      allow(Customer).to receive(:find).and_return(customer)
      allow(customer).to receive(:update).and_return(false)
      put "/customers/8", valid_params
      expect(last_response).to be_bad_request
    end

  end

  describe "delete /customers/:id" do

    let(:customer) { Customer.new }

    it "finds the right customer" do
      expect(Customer).to receive(:find).with("8").and_return(customer)
      delete "/customers/8"
    end

    it "returns a successful status if the customer is destroyed" do
      allow(Customer).to receive(:find).and_return(customer)
      allow(customer).to receive(:destroy).and_return(true)
      delete "/customers/8"
      expect(last_response).to be_ok
    end

    it "returns a bad request status if the customer is not destroyed" do
      allow(Customer).to receive(:find).and_return(customer)
      allow(customer).to receive(:destroy).and_return(false)
      delete "/customers/8"
      expect(last_response).to be_bad_request
    end

  end

end
