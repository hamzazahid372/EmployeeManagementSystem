class HolidaysController < ApplicationController
  load_and_authorize_resource

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @holiay.update(holiday_params)
      @holiday = Current.company.holidays
      flash[:notice] = t 'holiday.updated'
    else
      flash[:error] = @holiday.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def holiday_params
    params.require(:holiday).permit(:day, :every_year)
  end
end
