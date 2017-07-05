module Api
  module V1
    class TasksController < ApplicationController
      before_filter :set_task, only: [:show, :update, :destroy]

      # GET /tasks
      def index
        @tasks = Task.all

        render json: @tasks
      end
      # GET /tasks/1
      def show
        render json: @task
      end

      # POST /tasks
      def create
        @task = Task.new(params[:task])

        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tasks/1
      def update
        if @task.update(params[:task])
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tasks/1
      def destroy
        @task.destroy
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end
    end
  end
end
