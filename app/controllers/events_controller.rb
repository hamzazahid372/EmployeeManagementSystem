# frozen_string_literal: true

# Event Controller
class EventsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  # GET /events
  def index
    respond_to do |format|
      format.html
      format.json do
        @events = @events.map { |e| { id: e.id, title: e.title, start: e.start, end: e.end, url: event_url(e) } }
        render json: @events
      end
    end
  end

  # POST /events
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

  # PATCH /events/:id
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

  # GET /events/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /events/new
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # DELETE /events/:id
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
