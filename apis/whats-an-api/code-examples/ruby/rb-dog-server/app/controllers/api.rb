get '/api/dogs' do
	Dog.all.order(id: :asc).to_json
end

patch '/api/dogs/:id/taint' do
	Dog.find(params[:id]).taint!
end

post '/api/dogs/resurrect' do
	Dog.resurrection
end