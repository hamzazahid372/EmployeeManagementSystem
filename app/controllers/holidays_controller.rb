class HolidaysController < ApplicationController
  load_and_authorize_resource

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    if @holiday.save
      @holidays = Current.company.holidays
      flash[:notice] = t 'holiday.created'
    else
      flash[:error] = @holiday.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @holiday.update(holiday_params)
      @holidays = Current.company.holidays
      flash[:notice] = t 'holiday.updated'
    else
      flash[:error] = @holiday.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @holiday.destroy
      @holidays = Current.company.holidays
      flash[:notice] = t 'holiday.destroyed'
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
