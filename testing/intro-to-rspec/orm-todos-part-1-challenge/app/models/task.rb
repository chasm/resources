class Task < ActiveRecord::Base

	def to_s
		"[#{marker}] #{id}. #{description}"
	end

	def marker
		completed ? "X" : " "
	end

	def tick!
		update(completed: true)
	end

	def untick!
		update(completed: false)
	end

end