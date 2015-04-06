get '/items' do
  @items = Item.all
  erb :index
end

post '/items' do
  Item.create(params)
  redirect '/items'
end