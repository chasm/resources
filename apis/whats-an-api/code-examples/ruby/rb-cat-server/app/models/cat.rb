require 'faker'	

class Cat < ActiveRecord::Base

	def self.resurrection
		Cat.destroy_all
		image_urls = ["http://bit.ly/1u8TDf8", "http://bit.ly/1kYr0bq", "http://bit.ly/1finWXM", "http://bit.ly/1Du1SGM", "http://bit.ly/1hYOg6w"]
		image_urls.each { |image_url| Cat.create(name: Faker::Name.name, image_url: image_url) }
	end

	def taint!
		update(name: name.split('').shuffle.join(''), image_url: "http://bit.ly/1AVBy6z")
	end

end