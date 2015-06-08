get "/api/v1/users" do
  User.all.to_json
end

get "/api/v1/users/:id/articles" do
  User.find_by_id(params[:id]).articles.to_json
end

post "/api/v1/articles/:id/comments" do
  article = Article.find_by_id(params[:id])
  comment = article.comments.new(body: params[:body])
  if comment.save
    comment.to_json
  else
    status 400
  end
end