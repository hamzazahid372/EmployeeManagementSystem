# frozen_string_literal: true

# Time Log Controller
class TimeLogsController < ApplicationController
  load_and_authorize_resource :task, find_by: :sequence_num, only: %i[index new create]
  load_and_authorize_resource :time_log, through: :task, only: %i[index new create]
  load_and_authorize_resource :time_log, only: %i[destroy]

  # GET /tasks/:task_id/time_logs
  def index
    @time_logs = @time_logs.includes(:user)
    @time_logs = @time_logs.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  # GET /tasks/:task_id/time_logs/new
  def new
    respond_to do |format|
      format.js
    end
  end

  # POST /tasks/:task_id/time_logs
  def create
    @time_log.user_id = current_user.id
    if @time_log.save
      flash[:notice] = t 'time_log.created'
    else
      flash[:error] = @time_log.errors.full_messages
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @time_log.destroy
      flash.now[:notice] = t 'time_log.destroyed'
    else
      flash.now[:error] = t 'time_log.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  def time_log_params
    params.require(:time_log).permit(:hours, :comment, :activity_id)
  end
end
