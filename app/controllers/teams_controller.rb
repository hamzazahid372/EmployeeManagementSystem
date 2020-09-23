# frozen_string_literal: true

# Teams Controller
class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  def index
    @teams = Team.all
    @users = User.all
    if @teams.nil?
      flash[:notice] = 'No Team exist yet'
      redirect_to new_team_path
    end
  end

  def show
    @users = User.all
  end

  def new
    @users = User.all
  end

  def edit
    @users = User.all
  end

  def create
    if @team.save
      flash[:notice] = 'Team created successfully'
      render :show
    else
      errors = ''
      @task.errors.full_messages.each do |msg|
        errors = errors + msg + ', '
      end
      flash[:error] = errors
      @users = User.all
      render :new
    end
  end

  def update
    if @team.update(team_params)
      flash[:notice] = 'Team updated successfully'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    flash[:notice] = 'Team removed successfully'
    redirect_to teams_url
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :lead_id, :sequence_num)
  end
end
