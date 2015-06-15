require_relative '../../config/application.rb'
require_relative '../../app/views/console.rb'

class TasksController

	def self.print_list!
		if Task.all.any?
			render!(Task.all)
		else
			render!("todo list is empty!")
		end
	end

	def self.add_to_list!(description)
		task = Task.new(description: description)
		if task.save
			render!('task successfully created')
		else
			render!('task must have a description')
		end
	end

	def self.delete_from_list!(id)
		if task = Task.find_by_id(id)
			task.destroy
			render!('task successfully deleted')
		else
			render!("task does not exist")
		end
	end

	def self.tick!(id)
		if task = Task.find_by_id(id)
			task.tick!
			render!('task completed!')
		else
			render!("task does not exist")
		end
	end

	def self.untick!(id)
		if task = Task.find_by_id(id)
			task.untick!
			render!('task set to incomplete')
		else
			render!("task does not exist")
		end
	end

	private

		def self.render!(message)
			Console.render!(message)
		end

end