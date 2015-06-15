require 'spec_helper'
require_relative './../app/controllers/tasks_controller.rb'

describe "TasksController" do

  let(:incomplete_task) { Task.create(description: Faker::Lorem.sentence) }
  let(:complete_task) { Task.create(description: Faker::Lorem.sentence, completed: true) }

  before do 
    allow(TasksController).to receive(:render!)
  end

  describe "#print_list!" do

    context "if no tasks in the DB" do

      it "renders 'todo list is empty!" do
        expect(TasksController).to receive(:render!).with("todo list is empty!")
        TasksController.print_list!
      end

    end

    context "if tasks in the DB" do

      it "renders all tasks in the DB" do
        5.times { Task.create(description: Faker::Lorem.sentence) }
        expect(TasksController).to receive(:render!).with(Task.all)
        TasksController.print_list!
      end

    end

  end

  describe "#add_to_list!(description)" do

    context "if description is provided" do

      it "should add an item with given description to the DB" do
        TasksController.add_to_list!("meow")
        expect(Task.find_by_description("meow")).to be_truthy
      end

      it "should render a success message" do
        expect(TasksController).to receive(:render!).with("task successfully created")       
        TasksController.add_to_list!("meow")
      end

    end

  end

  describe "#delete_from_list!(id)" do

    context "if valid id" do

      it "deletes the task with given id from the DB" do
        TasksController.delete_from_list!(incomplete_task.id)
        expect(Task.find_by_id(incomplete_task.id)).to be_nil
      end

      it "should render a success message" do
        expect(TasksController).to receive(:render!).with("task successfully deleted")
        TasksController.delete_from_list!(incomplete_task.id)
      end

    end

    context "if invalid id" do

      it "should render an error message" do
        expect(TasksController).to receive(:render!).with("task does not exist")
        TasksController.delete_from_list!("not even an id")
      end

    end

  end

  describe "#tick!(id)" do

    context "if valid id" do

      it "should update task with given id's completed attr to true" do
        TasksController.tick!(incomplete_task.id)
        incomplete_task.reload
        expect(incomplete_task.completed).to be_truthy
      end

      it "should set render a success message" do
        expect(TasksController).to receive(:render!).with("task completed!")
        TasksController.tick!(incomplete_task.id)
      end

    end

    context "if invalid id" do

      it "should render an error message" do
        expect(TasksController).to receive(:render!).with("task does not exist")
        TasksController.tick!("not even an id")
      end

    end

  end

  describe "#untick!(id)" do

    context "if valid id" do 

      it "should update task with given id's completed attr to false" do
        TasksController.untick!(complete_task.id)
        complete_task.reload
        expect(complete_task.completed).to be_falsey
      end

      it "should render a success message" do
        expect(TasksController).to receive(:render!).with("task set to incomplete")
        TasksController.untick!(complete_task.id)
      end

    end

    context "if invalid id" do

      it "should render an error message" do
        expect(TasksController).to receive(:render!).with("task does not exist")
        TasksController.untick!("not even an id")
      end

    end

  end

  after do
    Task.destroy_all
  end

end