# frozen_string_literal: true

# Task Controller
class TasksController < ApplicationController
  include TaskFilters

  load_and_authorize_resource find_by: :sequence_num

  def index
    add_breadcrumb 'Tasks', tasks_path

    @tasks = apply_filters(@tasks, params)
    @tasks = @tasks.page(params[:page]).per_page(PER_PAGE)
    @users = User.accessible_by(current_ability)
    @projects = Project.accessible_by(current_ability)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    add_breadcrumb 'Tasks', tasks_path
    add_breadcrumb @task.title, task_path(@task)

    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb 'Tasks', tasks_path
    add_breadcrumb 'Create Task', new_task_path

    @users = User.accessible_by(current_ability)
    @projects = Project.accessible_by(current_ability)
    @task.project_id = params[:project_id] if params[:project_id].present?
    respond_to do |format|
      format.html
    end
  end

  def edit
    add_breadcrumb 'Tasks', tasks_path
    add_breadcrumb @task.title, task_path(@task)
    add_breadcrumb 'Update', edit_task_path

    @users = User.accessible_by(current_ability)
    @projects = Project.accessible_by(current_ability)
    respond_to do |format|
      format.html
    end
  end

  def create
    @task.created_by_id = current_user.id
    if @task.save
      flash[:notice] = t 'task.created'
      redirect_to @task
    else
      errors = @task.errors.full_messages
      flash[:error] = errors
      @users = User.accessible_by(current_ability)
      @projects = Project.accessible_by(current_ability)
      render :new
    end
    respond_to do |format|
      format.html
    end
  end

  def update
    if @task.update(task_params)
      flash[:notice] = t 'task.updated'
      redirect_to @task
    else
      errors = @task.errors.full_messages
      flash[:error] = errors
      @users = User.accessible_by(current_ability)
      @projects = Project.accessible_by(current_ability)
      render :edit
    end
    respond_to do |format|
      format.html
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = t 'task.destroyed'
      redirect_to tasks_url
    else
      flash[:notice] = t 'task.not_destroyed'
    end
    respond_to do |format|
      format.html
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date,
                                 :due_date, :expected_start_date, :expected_end_date,
                                 :priority, :status, :assignee_id, :reviewer_id,
                                 :progress, :project_id)
  end
end
