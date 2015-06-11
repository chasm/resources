require 'spec_helper'
require_relative './../app/controllers/tasks_controller.rb'


describe "TasksController" do

  let!(:incomplete_task) { Task.create(description: Faker::Lorem.sentence) }
  let(:complete_task) { Task.create(description: Faker::Lorem.sentence, completed: true) }
  let(:tasks_controller) { TasksController.new }

  describe "#add_to_list(description)" do
    it "should add an item with given description to the DB" do
      tasks_controller.add_to_list("meow")
      expect(Task.find_by_description("meow")).to be_truthy
    end
  end

  describe "#delete_from_list(id)" do
    it "should delete from DB the task with given id" do
      tasks_controller.delete_from_list(incomplete_task.id)
      expect(Task.find_by_id(incomplete_task.id)).to be_nil
    end
  end

  after do
    Task.destroy_all
  end

end