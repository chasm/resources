get '/' do
  redirect '/items'
end

get '/items' do
  @items = Item.all
  erb :index
end

get '/items/:id' do
  @item = Item.find(params[:id])
  erb :show
end

get '/items/new' do
  erb :new
end

post '/items' do
  if params[:name] && params[:price]
    Item.create(name: params[:name], price: params[:price].to_i)
    redirect '/items/new'
  else
    status 401
    body "u suck"
  end
end

get '/items/:id/edit' do
  @item = Item.find(params[:id])
  erb :edit
end

patch '/items/:id' do
  Item.find(params[:id]).update(name: params[:name], price: params[:price].to_i)
  redirect '/items/#{params[:id]}'
end

delete '/items/:id' do
  Item.find(params[:id]).destroy
end