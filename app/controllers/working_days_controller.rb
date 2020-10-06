class WorkingDaysController < ApplicationController
  load_and_authorize_resource

  # GET /working_days/:id/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # PATCH /working_days/:id
  def update
    if @working_day.update(working_day_params)
      @working_days = Current.company.working_days
      flash[:notice] = t 'working_day.updated'
    else
      flash[:error] = @working_day.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def working_day_params
    params.require(:working_day).permit(:from, :to, :off_day)
  end
end
