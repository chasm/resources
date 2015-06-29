require 'sinatra/json'

get "/api/v1/users" do
  json User.all
end

get "/api/v1/users/:user_id/articles" do
  user = User.find(params[:user_id])  
  json user.articles
end

post "/api/v1/articles/:article_id/comments" do
  article = Article.find(params[:article_id])
  comment = article.comments.new(body: params[:body], user_id: params[:user_id])
  if comment.save
    json comment
  else
    body json({"errors" => comment.errors.full_messages})
    status 400
  end
end