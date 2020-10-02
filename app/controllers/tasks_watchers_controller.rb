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

  def create
    if @tasks_watcher.save
      flash.now[:notice] = t 'tasks_watcher.created'
    else
      errors = @tasks_watcher.errors.full_messages.join(', ')
      flash.now[:error] = errors
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
