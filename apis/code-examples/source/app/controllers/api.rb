get '/cats' do
	Cat.all.to_json
end

patch '/cats/:id/taint' do
	Cat.find(params[:id]).taint!
end

post '/cats/resurrect' do
	Cat.resurrection
end