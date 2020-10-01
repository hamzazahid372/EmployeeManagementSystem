class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  def index
    add_breadcrumb 'Projects', projects_path
    @projects = @projects.page(params[:page]).per_page(PER_PAGE)
    respond_to do |format|
      format.html
    end
  end

  def show
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb @project.name, project_path(@project)

    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb 'Create Project', new_project_path

    respond_to do |format|
      format.html
    end
  end

  def edit
    add_breadcrumb 'Projects', projects_path
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb 'Update', edit_project_path(@project)

    respond_to do |format|
      format.html
    end
  end

  def create
    success = true
    if @project.save
      flash[:notice] = t 'project.created'
    else
      errors = ''
      @project.errors.full_messages.each do |msg|
        errors = errors + msg + ', '
      end
      flash[:error] = errors
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

  def update
    success = true
    if @project.update(project_params)
      flash[:notice] = t 'project.updated'
    else
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

  def destroy
    if @project.destroy
      flash[:notice] = t 'project.destroyed'
    end
    respond_to do |format|
      format.html { redirect_to @project }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date)
  end
end

