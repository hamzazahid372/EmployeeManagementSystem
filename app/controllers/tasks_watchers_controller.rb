# frozen_string_literal: true

# Tasks Watchers Controller
class TasksWatchersController < ApplicationController
  load_and_authorize_resource :task, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :task, only: %i[index create new]
  load_and_authorize_resource :tasks_watcher, only: %i[destroy]

  def new
    respond_to do |format|
      format.js
    end
  end
  
  def index
    @tasks_watchers = @tasks_watchers.includes(:watcher)
    @tasks_watchers = @tasks_watchers.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  def create
    if @tasks_watcher.save
      flash.now[:notice] = t 'tasks_watcher.created'
    else
      errors = @tasks_watcher.errors.full_messages.join(', ')
      flash.now[:error] = errors
    end
    respond_to do |format|
      if errors
        format.js { render js: "alert('#{errors}');" }
      else
        format.js
      end
    end
  end

  def destroy
    @task = @tasks_watcher.task
    if @tasks_watcher.destroy
      flash.now[:notice] = t 'tasks_watcher.destroyed'
    else
      flash.now[:notice] = t 'tasks_watcher.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  private 

  def tasks_watcher_params
    params.require(:tasks_watcher).permit(:task_id, :watcher_id, :watcher_type)
  end
end
