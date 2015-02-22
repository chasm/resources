class CommitParser

	attr_reader :histogram, :error

	def initialize(username)
		@data = HTTParty.get("https://api.github.com/users/#{username}/events")
		load_commits!
		load_words!
		load_histogram!
	end

	def load_commits!
		events = @data.select { |event| event["type"] == "PushEvent" }
		@commits = events.map { |event| event["payload"]["commits"] }.flatten.map { |commit| commit["message"] }
	end 

	def load_words!
		@words = @commits.map { |commit| commit.split(" ") }.flatten.map { |word| word.downcase }
	end

	def load_histogram!
		@histogram = @words.uniq.map { |word| [word.to_sym, "* " * @words.count(word)] }.to_h.sort_by {|k,v| v }.reverse
	end

	def rate_limit_exceeded?
		@data["message"].include?("API rate limit exceeded")
	end

end