def current_user
  User.find_by_uid(session[:uid])
end

before do
  pass if request.path_info =~ /^\/auth\//
  redirect '/auth/facebook' unless current_user
end

get '/' do
  @user = current_user
  erb :index
end

get '/auth/facebook/callback' do
  auth = env['omniauth.auth']
  session[:uid] = auth['uid']
  User.create_from_omniauth(auth) unless current_user
  redirect '/'
end

get '/auth/failure' do
  # omniauth redirects to /auth/failure when it encounters a problem
  # so you can implement this as you please
end