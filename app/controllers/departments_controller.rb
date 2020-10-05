# frozen_string_literal: true

# Department Controller
class DepartmentsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  # GET /departments/new
  def new
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
    respond_to do |format|
      format.html
    end
  end

  # PATCH /departments/:id
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
    @departments = @departments.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
    end
  end

  # GET /departments/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # DELETE /departments/:id
  def destroy
    success = true
    if @department.destroy
      flash[:notice] = t 'department.destroyed'
    else
      flash[:notice] = t 'department.failure.cannot_destroyed'
      success = false
    end
    respond_to do |format|
      if success
        format.html { redirect_to departments_path }
      else
        format.html {redirect_to @department}
      end
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
