# frozen_string_literal: true

# Projects Users Controller
class ProjectsUsersController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :project, only: %i[index create new]
  load_and_authorize_resource only: %i[destroy]
  
  def index
    @projects_users = @projects_users.includes(:user)
    @projects_users = @projects_users.page(params[:page]).per_page(PER_PAGE)
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
    if @projects_user.save
      flash[:notice] = t 'projects_user.created'
    else
      errors = @projects_user.errors.full_messages.join(', ')
      flash[:error] = errors
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    if @projects_user.destroy
      flash[:notice] = t 'projects_user.destroyed'
    else
      flash[:notice] = t 'projects_user.not_destroyed'
    end
    redirect_to project_path(@projects_user.project)
    respond_to do |format|
      format.html
    end
  end

  def projects_user_params
    params.require(:projects_user).permit(:user_id, :project_id)
  end
end
