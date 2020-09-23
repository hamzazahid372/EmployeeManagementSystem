# frozen_string_literal: true

# Task Controller
class TasksController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    @tasks = Task.all
    @users = User.all
    if @tasks.nil?
      flash[:notice] = 'No Task exist yet'
      redirect_to new_task_path
    end
  end

  def show
    @users = User.all
  end

  def new
    @users = User.all
  end

  def edit
    @users = User.all
  end

  def create
    @task.project_id = 2
    if @task.save
      flash[:notice] = 'Task created successfully'
      render :show
    else
      errors = ''
      @task.errors.full_messages.each do |msg|
        errors = errors + msg + ', '
      end
      flash[:error] = errors
      @users = User.all
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task updated successfully'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Task removed successfully'
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date,
                                 :due_date, :expected_start_date, :expected_end_date,
                                 :priority, :status, :assignable_id,
                                 :assignable_type, :progress, :sequence_num)
  end
end
