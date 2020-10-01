# frozen_string_literal: true

# Projects Departments Controller
class ProjectsDepartmentsController < ApplicationController
  load_and_authorize_resource :department, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :department, only: %i[index create new]
  load_and_authorize_resource :projects_department, only: %i[destroy]
  
  def index
    @projects_departments = @projects_departments.includes(:project)
    @projects_departments = @projects_departments.page(params[:page]).per_page(PER_PAGE)
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
    if @projects_department.save
      flash.now[:notice] = t 'projects_department.created'
    else
      errors = @projects_department.errors.full_messages.join(', ')
      flash.now[:error] = errors
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @department = @projects_department.department
    if @projects_department.destroy
      flash.now[:notice] = t 'projects_department.destroyed'
    else
      flash.now[:notice] = t 'projects_department.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  def projects_department_params
    params.require(:projects_department).permit(:department_id, :project_id)
  end
end
