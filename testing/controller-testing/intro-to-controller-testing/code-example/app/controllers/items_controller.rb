get '/items' do
  @errors = session[:errors]
  session[:errors] = nil
  @items = Item.all
  erb :index
end

post '/items' do
  item = Item.new(params)
  session[:errors] = "invalid form data" unless item.save
  redirect '/items'
end