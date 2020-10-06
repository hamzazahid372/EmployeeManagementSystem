# frozen_string_literal: true

# Department Controller
class DepartmentsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  # GET /departments/new
  def new
    add_breadcrumb 'Departments', departments_path
    add_breadcrumb 'Create Department', new_department_path(@department)
    respond_to do |format|
      format.html
    end
  end

  # POST   /departments
  def create
    success = true
    if @department.save
      flash[:notice] = t 'department.created'
    else
      flash[:error] = errors.full_messages
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to @department }
      else
        format.html { render 'new' }
      end
    end
  end

  # GET /departments/:id/edit
  def edit
    add_breadcrumb 'Departments', departments_path
    add_breadcrumb @department.name, department_path(@department)
    add_breadcrumb 'Update', edit_department_path(@department)
    respond_to do |format|
      format.html
    end
  end

  # PUT /departments/:id
  def update
    success = true
    if @department.update(department_params)
      flash[:notice] = t 'department.updated'
    else
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to @department }
      else
        format.html { render 'new' }
      end
    end
  end

  # GET /departments
  def index
    add_breadcrumb 'Departments', departments_path
    @departments = @departments.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
    end
  end

  # GET /departments/:id
  def show
    add_breadcrumb 'Departments', departments_path
    add_breadcrumb @department.name, department_path(@department)
    respond_to do |format|
      format.html
    end
  end

  # DELETE /departments/:id
  def destroy
    if @department.can_destroy?
      if @department.destroy
        flash[:notice] = t('department.destroyed')
      else
        flash[:error] = @department.errors.full_messages
      end
    else
      flash[:error] = @department.errors.full_messages
    end

    respond_to do |format|
      format.html do
        if flash[:error].blank?
          redirect_to departments_path
        else
          redirect_to @department
        end
      end
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
