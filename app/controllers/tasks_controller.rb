# frozen_string_literal: true

# Task Controller
class TasksController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  respond_to :html

  def index
    @users = User.all
    if @tasks.blank?
      flash[:notice] = t 'task.not_exist'
      redirect_to new_task_path
    end
  end

  def show
  end

  def new
    @users = User.all
  end

  def edit
    @users = User.all
  end

  def create
    @task.project_id = 2
    @task.created_by_id = current_user.id
    if @task.save
      flash[:notice] = t 'task.created'
      redirect_to @task
    else
      errors = @task.errors.full_messages.join(', ')
      flash[:error] = errors
      @users = User.all
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:notice] = t 'task.updated'
      redirect_to @task
    else
      errors = @task.errors.full_messages.join(', ')
      flash[:error] = errors
      @users = User.all
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = t 'task.destroyed'
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
