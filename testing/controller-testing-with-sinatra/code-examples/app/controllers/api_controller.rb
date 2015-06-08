require 'sinatra/json'

get '/api/items' do
  json Item.all
end

post '/api/items' do
  item = Item.create(params)
  item.id ? (json item) : (status 400)
end