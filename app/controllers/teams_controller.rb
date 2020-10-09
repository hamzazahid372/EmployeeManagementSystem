# frozen_string_literal: true

# Team Controller
class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  # GET /teams
  def index
    add_breadcrumb 'Teams', teams_path

    @teams = @teams.includes(:created_by, :lead).page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /teams/:id
  def show
    add_breadcrumb 'Teams', teams_path
    add_breadcrumb @team.name, team_path(@team)

    respond_to do |format|
      format.html
    end
  end

  # GET /teams/new
  def new
    add_breadcrumb 'Teams', teams_path
    add_breadcrumb 'Create Team', new_team_path

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /teams/:id/edit
  def edit
    add_breadcrumb 'Teams', teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb 'Update', edit_team_path(@team)

    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /teams
  def create
    @team.created_by_id = current_user.id
    if @team.save
      flash[:notice] = t 'team.created'
      redirect_to @team
    else
      errors = @team.errors.full_messages
      flash[:error] = errors
      render :new
    end
    respond_to do |format|
      format.html
    end
  end

  # PATCH /teams/:id
  def update
    if @team.update(team_params)
      flash[:notice] = t 'team.updated'
      redirect_to @team
    else
      errors = @team.errors.full_messages
      flash[:error] = errors
      render :edit
    end
    respond_to do |format|
      format.html
    end
  end

  # DELETE /teams/:id
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

  # GET /teams/search
  def search
    @teams = @teams.search_teams(params[:q]).map { |t| { id: t.id, name: t.name } }
    respond_to do |format|
      format.json { render json: @teams.to_json }
    end
  end

  def search_kick
    @teams = Team.search(params[:search], match: :word_start)
    respond_to do |format|
      format.js { render 'index' }
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :lead_id)
  end
end
