require_relative '../../config/application.rb'
require_relative '../../app/views/console.rb'

class TasksController

	def self.print_list
		puts Task.all
	end

	def self.add_to_list(description)
		Task.create(description: description)
	end

	def self.delete_from_list(id)
		if task = Task.find_by_id(id)
			task.destroy
		else
			Console.render("task does not exist")
		end
	end

	def self.tick(id)
		if task = Task.find_by_id(id)
			task.tick!
		else
			Console.render("task does not exist")
		end
	end

	def self.untick(id)
		if task = Task.find_by_id(id)
			task.untick!
		else
			Console.render("task does not exist")
		end
	end

	def self.render(message)
		Console.render(message)
	end

end
