get "/customers/:customer_id/notes" do
  customer = set_notes_customer
  @notes = customer.notes
  erb :notes, layout: false
end

post "/customers/:customer_id/notes" do
  customer = set_notes_customer
  note = customer.notes.build(note_params)
  if note.save
    json note: note
  else
    status 400
  end
end

def note_params
  params[:note]
end

def set_notes_customer
  Customer.find(params[:customer_id])
end
