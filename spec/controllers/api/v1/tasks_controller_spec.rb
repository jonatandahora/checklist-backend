require 'rails_helper'
require 'rails_helper'

RSpec.describe Api::V1::TasksController, :type => :controller do

  it "retrieves a list of tasks" do
    FactoryGirl.create_list(:task, 10)

    get :index
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['tasks'].length).to eq(10)
  end

  it "retrieves a task" do
    task = FactoryGirl.create(:task)

    get :show, {id: task.id}
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['task']['description']).to eq(task.description)
    expect(json['task']['priority']).to eq(task.priority)
    expect(json['task']['finished']).to eq(task.finished)
  end

  describe "POST create" do
    it "creates a new task" do
      valid_attributes = FactoryGirl.build(:task).attributes.delete_if{|k,v| v.nil?}

      expect {
        post :create , :task => valid_attributes, :format => :json
      }.to change(Task, :count).by(1)

      expect(response).to be_success
    end

    it "fails to create a new task" do
      invalid_attributes = FactoryGirl.build(:task).attributes.delete_if{|k,v| v.nil?}
      invalid_attributes['description'] = nil

      post :create , :task => invalid_attributes, :format => :json

      json = JSON.parse(response.body)

      expect(json).to eq({"description"=>["can't be blank"]})
      expect(response.status).to eq(422)
    end
  end

  describe "PUT update" do
    it "updates task" do
      task = FactoryGirl.create(:task)
      new_task_description = 'Another description'

      put :update , {id: task.id, :task => { description: new_task_description}}, :format => :json

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['task']['description']).to eq(new_task_description)
    end

    it "fails to update task due to invalid description" do
      task = FactoryGirl.create(:task)

      put :update , {id: task.id, :task => { description: nil}}, :format => :json

      json = JSON.parse(response.body)

      expect(json).to eq({"description"=>["can't be blank"]})
      expect(response.status).to eq(422)
    end
  end

  describe "DELETE destroy" do
    it "deletes a task" do
      task = FactoryGirl.create(:task)

      expect{
        delete :destroy , {id: task.id}
      }.to change(Task, :count).by(-1)

      expect(response.status).to eq(204)
    end

    it "fails to delete a task" do
      task = FactoryGirl.create(:task)
      task_id = task.id
      task.destroy

      delete :destroy , {id: task_id}

      expect(response.status).to eq(404)
    end
  end
end
