class EventsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    add_breadcrumb 'Events', events_path
    respond_to do |format|
      format.html
      format.json do
        @events = @events.map { |e| { id: e.id, title: e.title, start: e.start, end: e.end, url: event_url(e) } }
        render json: @events
      end
    end
  end

  def create
    @event.created_by_id = current_user.id
    if @event.save
      flash.now[:notice] = t 'event.success.created'
    else
      flash.now[:error] = @event.errors.full_messages
    end
    respond_to do |format|
      format.html { redirect_to request.referer }
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
    add_breadcrumb 'Events', events_path
    add_breadcrumb @event.title, event_path(@event)
    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb 'Events', events_path
    add_breadcrumb 'Create Event', new_event_path
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /events/:id/edit
  def edit
    add_breadcrumb 'Events', events_path
    add_breadcrumb @event.title, event_path(@event)
    add_breadcrumb 'Update', edit_event_path(@event)
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
    params.require(:event).permit(:start, :title, :description, :sequence_num, :created_by_id, :end)
  end
end
