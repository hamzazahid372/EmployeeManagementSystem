# frozen_string_literal: true

# Projects Departments Controller
class ProjectsDepartmentsController < ApplicationController
  load_and_authorize_resource :department, find_by: :sequence_num, only: %i[index create new]
  load_and_authorize_resource through: :department, only: %i[index create new]
  load_and_authorize_resource :projects_department, only: %i[destroy]

  #GET /departments/department_id/projects_departments
  def index
    @projects_departments = @projects_departments.includes(:project)
    @projects_departments = @projects_departments.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  #GET /departments/department_id/projects_departments/new
  def new
    respond_to do |format|
      format.js
    end
  end

  #POST /departments/department_id/projects_departments
  def create
    if @projects_department.save
      flash.now[:notice] = t 'projects_department.created'
    else
      errors = @projects_department.errors.full_messages
      flash.now[:error] = errors
    end
    respond_to do |format|
      format.js
    end
  end

  # DELETE /projects_departments/id
  def destroy
    @department = @projects_department.department
    if @projects_department.destroy
      flash.now[:notice] = t 'projects_department.destroyed'
    else
      flash.now[:error] = t 'projects_department.not_destroyed'
    end
    respond_to do |format|
      format.js
    end
  end

  private 

  def projects_department_params
    params.require(:projects_department).permit(:department_id, :project_id)
  end
end
