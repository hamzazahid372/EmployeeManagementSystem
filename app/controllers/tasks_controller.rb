# frozen_string_literal: true

# Task Controller
class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @users = User.all
  end

  def show
    if Task.find_by sequence_num: params[:sequence_num]
      @task = Task.find(params[:sequence_num])
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
    if Task.find_by sequence_num: params[:sequence_num]
      @task = Task.find(params[:sequence_num])
      @users = User.all
    else
      @users = User.all
      @task = Current.company.tasks.build
      render 'new'
    end
  end

  def create
    @task = Current.company.tasks.build(task_params)
    @task.project_id = 2
    @users = User.all
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:sequence_num])
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:sequence_num])
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :due_date,
                                 :expected_start_date, :expected_end_date,
                                 :priority, :status, :assignable_id,
                                 :assignable_type, :progress, :sequence_num)
  end
end
