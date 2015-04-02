get '/' do
  erb :index
end

get '/cats' do
  Cat.all.to_json
end

post '/cats' do
  name = params[:name]
  product = params[:product]
  if name == "chairvan"
    status 400
  else
    Cat.create(name: params[:name], product: params[:product])
  end
end