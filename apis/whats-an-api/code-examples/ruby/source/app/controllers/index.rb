require 'httparty'

get '/' do
	@cats = Cat.all
	# @dogs = HTTParty.get('dog-server.azurewebsites.net/api/dogs')
	@dogs = []
	erb :index
end

patch '/dogs/:id/taint' do
	# HTTParty.patch('dog-server.azurewebsites.net/api/dogs/#{params[:id]}/taint')
	redirect '/'
end

post '/dogs/resurrect' do
	# HTTParty.post('dog-server.azurewebsites.net/api/dogs/resurrect')
	redirect '/'
end