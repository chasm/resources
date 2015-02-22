require 'faker'	

class Dog < ActiveRecord::Base

	def self.resurrection
		Dog.destroy_all
		image_urls = ["http://bit.ly/1vH9xJO","http://bit.ly/1B2asef","http://bit.ly/1z81Vkj","http://bit.ly/1qpl3HW","http://bit.ly/1wcbfsx"]
		image_urls.each { |image_url| Dog.create(name: Faker::Name.name, image_url: image_url) }
	end

	def taint!
		update(name: name.split('').shuffle.join(''), image_url: "http://bit.ly/1FdvDJ3")
	end

end