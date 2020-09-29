# frozen_string_literal: true

# Task Controller
class UsersTeamsController < ApplicationController
  load_and_authorize_resource :team
  load_and_authorize_resource through: :team

  def index
  end

  def show
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def create
    if @users_team.save
      flash[:notice] = t 'users_team.created'
      redirect_to @team
    else
      errors = @users_team.errors.full_messages.join(', ')
      flash[:error] = errors
      redirect_to @team
    end
    respond_to do |format|
      format.html
    end
  end

  def update
  end

  def destroy
  end

  def users_team_params
    params.require(:users_team).permit(:user_id, :team_id)
  end
end
