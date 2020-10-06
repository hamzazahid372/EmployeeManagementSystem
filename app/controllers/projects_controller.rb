# frozen_string_literal: true

# Project Controller
class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  #  /projects
  def index
    add_breadcrumb 'Projects', projects_path
    @projects = @projects.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
    end
  end

  # /projects/:id
  def show
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb @project.name, project_path(@project)

    respond_to do |format|
      format.html
    end
  end

  # /projects/new
  def new
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb 'Create Project', new_project_path

    respond_to do |format|
      format.html
    end
  end

  # /projects/:id/edit
  def edit
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb 'Update', edit_project_path(@project)

    respond_to do |format|
      format.html
    end
  end

  #  POST /projects
  def create
    success = true
    if @project.save
      flash[:notice] = t 'project.created'
    else
      flash[:error] = @project.errors.full_messages
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to @project }
      else
        format.html { render 'new' }
      end
    end
  end

  #  PATCH  /projects/:id
  def update
    success = true
    if @project.update(project_params)
      flash[:notice] = t 'project.updated'
    else
      success = false
      flash[:error] = @project.errors.full_messages
    end
    respond_to do |format|
      if success
        format.html { redirect_to @project }
      else
        format.html { render 'new' }
      end
    end
  end

  #  /projects/:id
  def destroy
    if @project.can_destroy?
      if @project.destroy
        flash[:notice] = t('project.destroyed')
      else
        flash[:error] = @project.errors.full_messages
      end
    else
      flash[:error] = @project.errors.full_messages
    end

    respond_to do |format|
      format.html do
        if flash[:error].blank?
          redirect_to projects_path
        else
          redirect_to @project
        end
      end
    end
  end

  # /projects/search
  def search
    @projects = @projects.search(params[:q]).map { |p| { id: p.id, name: p.name } }
    respond_to do |format|
      format.json { render json: @projects.to_json }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date)
  end
end
