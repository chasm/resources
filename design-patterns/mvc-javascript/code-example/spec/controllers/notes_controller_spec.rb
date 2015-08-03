require "spec_helper"

RSpec.describe "Notes Controller" do

  describe "get /customers/:customer_id/notes" do

    let(:note_1) { Note.new(content: "Contacted by email") }
    let(:note_2) { Note.new(content: "Contacted by phone") }
    let(:notes)  { [ note_1, note_2 ] }
    let(:customer)   { double("customer", notes: notes) }

    before { allow(Customer).to receive(:find).and_return(customer) }

    it "returns empty divs if there are no notes" do
      allow(customer).to receive(:notes).and_return([])
      get "/customers/8/notes"
      expect(last_response.body).to match(/class=.notes./)
    end

    describe "returns a list of notes in JSON" do

      before do
        allow(note_1).to receive(:id).and_return(33)
        allow(note_2).to receive(:id).and_return(45)
        get "/customers/8/notes"
      end

      it "returns a notes" do
        expect(last_response.body).to match(/class=.note./)
      end

      describe "returns all the notes for a customer" do
        before do
        end

        it "renders the first note" do
          expect(last_response.body).to match(/data-id=.33./)
        end

        it "renders the last note" do
          expect(last_response.body).to match(/data-id=.45./)
        end
      end

      it "returns the contents of notes" do
        expect(last_response.body).to include("Contacted by email")
      end
    end

  end

  describe "post /customers/:customer_id/notes" do

    let(:valid_params) { { "note" => { "content" => "Contacted" } } }
    let(:note) { Note.new(valid_params["note"]) }
    let(:notes) { double("notes", build: note) }
    let(:customer) { double("customer", notes: notes) }

    before { allow(Customer).to receive(:find).and_return(customer) }

    it "passes the parameters to the new note" do
      expect(notes).to receive(:build).with(valid_params["note"])
      post "/customers/8/notes", valid_params
    end

    it "returns the customer data if saved successfully" do
      allow(note).to receive(:save).and_return(true)
      post "/customers/8/notes", valid_params
      note_json = last_json["note"]
      expect(note_json["content"]).to eq("Contacted")
    end

    it "responds with a bad request if not saved successfully" do
      allow(customer).to receive(:save).and_return(false)
      post "/customers/8/notes", valid_params
      expect(last_response).to be_bad_request
    end

  end

end
