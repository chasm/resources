require "httparty"

get "/" do
	@cats = Cat.all
	@dogs = JSON.parse(HTTParty.get("https://dog-server.herokuapp.com/api/dogs"));
	erb :index
end

patch "/dogs/:id/taint" do
	HTTParty.patch("https://dog-server.herokuapp.com/api/dogs/#{params[:id]}/taint")
	redirect "/"
end

post "/dogs/resurrect" do
	HTTParty.post("dog-server.herokuapp.com/api/dogs/resurrect")
	redirect "/"
end