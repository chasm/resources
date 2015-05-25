get '/' do
  @students = Student.all
  erb :index
end

get '/students/:id' do
  puts params
  @student = Student.find(params[:id])
  erb :show
end

put '/students/:id' do
  puts params
  @student = Student.find(params[:id])
  @student.update(name: params[:name], biography: params[:biography])
  redirect "/students/#{@student.id}"
end

get '/students/:id/edit' do
  @student = Student.find(params[:id])
  erb :edit
end

post '/' do
  @student = Student.create(name:params[:name], biography:params[:biography])
  redirect '/'
end

delete '/students/:id' do
  @student = Student.find(params[:id])
  @student.destroy
  redirect '/'
end

get '/cats' do
  erb :cats
end