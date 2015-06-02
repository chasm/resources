require 'sinatra/json'

get '/' do
  erb :index
end

get '/cats' do
  json Cat.all
end

post '/cats' do
  name = params[:name]
  product = params[:product]
  if name == "chairvan" && product == "davis"
    status 400
  else
    @cat = Cat.create(name: params[:name], product: params[:product])
  end
  json @cat
end