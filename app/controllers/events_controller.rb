class EventsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  def index
    respond_to do |format|
      format.html
    end
  end

  def create
    success = true
    @event.created_by_id = current_user.id
    if @event.save
      flash[:notice] = t 'event.success.created'
    else
      errors = @event.errors.full_messages.join(', ')
      flash[:error] = errors
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to @event }
      else
        format.html { render 'new' }
      end
    end
  end

  def update
    success = true
    if @event.update(event_params)
      flash[:notice] = t 'event.success.updated'
    else
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to @event }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = t 'event.success.destroyed'
    end
    respond_to do |format|
      format.html { redirect_to @event }
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :title, :description, :sequence_num, :created_by_id)
  end
end
