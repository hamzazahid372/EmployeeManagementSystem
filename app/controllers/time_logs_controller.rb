class TimeLogsController < ApplicationController
  load_and_authorize_resource :task, find_by: :sequence_num
  load_and_authorize_resource :time_log, through: :task

  def index
    @time_logs = @time_logs.includes(:user)
    @time_logs = @time_logs.page(params[:page]).per_page(PER_PAGE)
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
    if @time_log.save
      flash.now[:notice] = t 'time_log.created'
      redirect_to @time_log
    else
      flash.now[:error] = t 'time_log.not_created'
    end
    respond_to do |format|
      format.js # create.js.erb
    end
  end

  def time_log_params
    params.require(:time_log).permit(:hours, :comment, :activity_id)
  end
end
