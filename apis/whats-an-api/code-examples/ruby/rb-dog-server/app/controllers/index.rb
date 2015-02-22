require 'httparty'

get '/' do
	@dogs = Dog.all
	@cats = JSON.parse(HTTParty.get('https://cat-server.herokuapp.com/cats'))
	erb :index
end

patch '/cats/:id/taint' do
	HTTParty.patch("https://cat-server.herokuapp.com/cats/#{params[:id]}/taint")
	redirect '/'
end

post '/cats/resurrect' do
	HTTParty.post('https://cat-server.herokuapp.com/cats/resurrect')
	redirect '/'
end