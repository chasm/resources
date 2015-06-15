require 'spec_helper'

describe "Task" do

  let (:complete_task) { Task.create(description: "meow", completed: true) }
  let (:incomplete_task) { Task.create(description: "meow") }

  describe "#marker" do

    context "if complete" do

      it "returns 'X'" do
        expect(complete_task.marker).to eq("X")
      end      

    end

    context "if incomplete" do

      it "returns ' '" do
        expect(incomplete_task.marker).to eq(" ")
      end

    end

  end

  describe "#to_s" do

    context "if complete" do

      it "prints the task with a marker indicating it is complete" do
        expect(complete_task.to_s).to eq("[X] #{complete_task.id}. #{complete_task.description}")
      end

      it "prints the task without a marker indicating it is incomplete" do
        expect(incomplete_task.to_s).to eq("[ ] #{incomplete_task.id}. #{incomplete_task.description}")
      end

    end

  end

  describe "#tick!" do

    it "sets the task's completed attr to true" do
      incomplete_task.tick!
      expect(incomplete_task.completed).to be_truthy
    end

  end

  describe "#untick!" do

    it "sets the task's completed attr to false" do
      complete_task.untick!
      expect(complete_task.completed).to be_falsey
    end

  end

  after do
    Task.destroy_all
  end

end