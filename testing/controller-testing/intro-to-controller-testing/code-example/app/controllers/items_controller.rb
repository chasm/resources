get '/items' do
  @errors = session[:error]
  session[:error] = nil
  @items = Item.all
  erb :index
end

post '/items' do
  item = Item.new(params)
  session[:error] = "invalid form data" unless item.save
  redirect '/items'
end