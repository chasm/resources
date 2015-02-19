require 'httparty'

get '/' do
	@cats = Cat.all
	# @dogs = HTTParty.get('dog-server.azurewebsites.net')
	@dogs = []
	erb :index
end

patch '/dogs/:id/taint' do
	puts "MEOW MEOW"
	# HTTParty.patch('dog-server.azurewebsites.net/dogs/#{params[:id]}/taint')
	redirect '/'
end

post '/dogs/resurrect' do
	puts "resurrected"
	# HTTParty.post('dog-server.azurewebsites.net/dogs/resurrect')
	redirect '/'
end