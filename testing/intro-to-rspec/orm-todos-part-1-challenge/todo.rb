require_relative 'config/application'
require_relative 'app/controllers/tasks_controller.rb'

user_input = ARGV
command = user_input.shift
params = user_input.join(" ")

case command
	when "list" then TasksController.print_list
 	when "add" then TasksController.add_to_list(params)
 	when "delete" then TasksController.delete_from_list(params.to_i)
 	when "tick" then TasksController.tick(params.to_i)
 	when "untick" then TasksController.untick(params.to_i)
 	else TasksController.render("available commands: list, add <description>, delete <id>, tick <id>, untick <id>")
end