class TimeLogsController < ApplicationController
  load_and_authorize_resource :task, find_by: :sequence_num
  load_and_authorize_resource :time_log, through: :task

  def index
    @time_logs = @time_logs.includes(:user)
    @time_logs = @time_logs.page(params[:page]).per_page(5)
    respond_to do |format|
      format.js # index.js.erb
    end
  end

  def new
    respond_to do |format|
      format.js # new.js.erb
    end
  end

  def create
    @time_log.user_id = current_user.id
    @time_log.assign_attributes(time_log_params)
    @time_log.save!
    respond_to do |format|
      format.js # create.js.erb
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def show
  end

  def time_log_params
    params.require(:time_log).permit(:hours, :comment, :activity_id)
  end
end
