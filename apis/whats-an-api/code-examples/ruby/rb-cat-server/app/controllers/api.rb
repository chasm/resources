get '/api/cats' do
	Cat.all.order(id: :asc).to_json
end

patch '/api/cats/:id/taint' do
	Cat.find(params[:id]).taint!
end

post '/api/cats/resurrect' do
	Cat.resurrection
end