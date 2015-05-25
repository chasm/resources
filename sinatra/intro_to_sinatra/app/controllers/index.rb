get '/' do
  @students = Student.all
  erb :index
end

post '/' do
  # puts params
  @student = Student.create(name:params[:name], biography:params[:biography])
  redirect '/'
end

get '/cats' do
  erb :cats
end