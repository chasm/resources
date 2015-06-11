require 'spec_helper'

describe "Task" do

  let(:incomplete_task) { Task.create(description: Faker::Lorem.sentence) }
  let(:complete_task) { Task.create(description: Faker::Lorem.sentence, completed: true) }

  describe "#to_s" do

    it "render the task's information nicely" do
      expect(incomplete_task.to_s).to eq("[ ] #{incomplete_task.id}. #{incomplete_task.description}")
    end

  end

  describe "#marker" do
    it "returns 'X' if task is complete" do
      expect(complete_task.marker).to eq("X")
    end
    it "returns ' ' if task is not complete" do
      expect(incomplete_task.marker).to eq(" ")
    end
  end

  describe "#tick!" do
    it "updates the task's complete attr to true" do
      incomplete_task.tick!
      expect(incomplete_task.completed).to be_truthy
    end
  end

  describe "#untick!" do
    it "updates the task's complete attr to false" do
      complete_task.untick!
      expect(complete_task.completed).to be_falsey
    end
  end

  after do
    Task.destroy_all
  end

end
