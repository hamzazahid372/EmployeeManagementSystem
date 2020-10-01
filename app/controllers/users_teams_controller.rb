# frozen_string_literal: true

# Users Teams Controller
class UsersTeamsController < ApplicationController
  load_and_authorize_resource :team, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :team, only: %i[index create new]
  load_and_authorize_resource only: %i[destroy]

  def index
    @users_teams = @users_teams.includes(:user)
    @users_teams = @users_teams.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    if @users_team.save
      flash[:notice] = t 'users_team.created'
    else
      errors = @users_team.errors.full_messages.join(', ')
      flash[:error] = errors
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @users_team.destroy
      flash[:notice] = t 'users_team.destroyed'
    else
      flash[:notice] = t 'users_team.not_destroyed'
    end
    redirect_to team_path(@users_team.team)
    respond_to do |format|
      format.html
    end
  end

  def users_team_params
    params.require(:users_team).permit(:user_id, :team_id)
  end
end
