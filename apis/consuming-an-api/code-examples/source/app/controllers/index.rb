require "httparty"

get "/:username" do
	@username = params[:username]
	parser = CommitParser.new(@username)
	@histogram = parser.histogram
	@error_message = "rate limit exceeded!" if parser.rate_limit_exceeded?
	erb :index
end