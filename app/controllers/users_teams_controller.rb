# frozen_string_literal: true

# Users Teams Controller
class UsersTeamsController < ApplicationController
  load_and_authorize_resource :team, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :team, only: %i[index create new]
  load_and_authorize_resource only: %i[destroy]

  # GET /teams/:team_id/users_teams
  def index
    @users_teams = @users_teams.includes(:user)
    @users_teams = @users_teams.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  # GET /teams/:team_id/users_teams/new
  def new
    respond_to do |format|
      format.js
    end
  end

# POST /teams/:team_id/users_teams
  def create
    if @users_team.save
      flash[:notice] = t 'users_team.created'
    else
      errors = @users_team.errors.full_messages
      flash[:error] = errors
    end
    respond_to do |format|
      format.js
    end
  end

  # DELETE /users_teams/:id
  def destroy
    @team = @users_team.team
    if @users_team.destroy
      flash[:notice] = t 'users_team.destroyed'
    else
      flash[:error] = t 'users_team.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  def users_team_params
    params.require(:users_team).permit(:user_id, :team_id)
  end
end
