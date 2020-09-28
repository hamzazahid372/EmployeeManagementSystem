# frozen_string_literal: true

# Team Controller
class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    @teams = @teams.page(params[:page]).per_page(PER_PAGE)
    @users = User.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @users = User.all
    respond_to do |format|
      format.html
    end
  end

  def edit
    @users = User.all
    respond_to do |format|
      format.html
    end
  end

  def create
    @team.created_by_id = current_user.id
    if @team.save
      flash[:notice] = t 'team.created'
      redirect_to @team
    else
      errors = @team.errors.full_messages.join(', ')
      flash[:error] = errors
      @users = User.all
      render :new
    end
    respond_to do |format|
      format.html
    end
  end

  def update
    if @team.update(team_params)
      flash[:notice] = t 'team.updated'
      redirect_to @team
    else
      errors = @team.errors.full_messages.join(', ')
      flash[:error] = errors
      @users = User.all
      render :edit
    end
    respond_to do |format|
      format.html
    end
  end

  def destroy
    if @team.destroy
      flash[:notice] = t 'team.destroyed'
      redirect_to teams_url
    else
      flash[:notice] = t 'team.not_destroyed'
    end
    respond_to do |format|
      format.html
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :lead_id,
                                 :sequence_num, :page)
  end
end
