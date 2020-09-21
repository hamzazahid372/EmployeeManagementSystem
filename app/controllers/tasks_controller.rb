# frozen_string_literal: true

# Task Controller
class TasksController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    @tasks = Task.all
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end


  def show
    if Task.find_by sequence_num: params[:id]
      @task = Task.find_by sequence_num: params[:id]
    else
      @users = User.all
      @task = Current.company.tasks.build
      render 'new'
    end
  end

  def new
    @users = User.all
    @task = Current.company.tasks.build
  end

  def edit
    if Task.find_by sequence_num: params[:id]
      @task = Task.find_by sequence_num: params[:id]
      @users = User.all
    else
      @users = User.all
      @task = Current.company.tasks.build
      render 'new'
    end
  end

  def create
    success = true
    begin
        Task.transaction do
          @task.project_id = 2
          @task.save!
        end
      rescue ActiveRecord::RecordInvalid
        success = false
      end
    if success

      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    success = true
    begin
      Task.transaction do
          @task.update(task_params)
        end
      rescue Exception => e
        success = false
    end
    if success
      redirect_to @task
    else
      render 'new'
    end
  end

  def destroy
    success = true
    begin
        Task.transaction do
          @task.destroy
        end
      rescue ActiveRecord::RecordInvalid
        success = false
      end
      if success
        redirect_to @task
      end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date,
                                 :due_date, :expected_start_date, :expected_end_date,
                                 :priority, :status, :assignable_id,
                                 :assignable_type, :progress, :sequence_num)
  end
end
