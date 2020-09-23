class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  def index
    @projects = Project.all
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      format.html
    end
    if @project.save
      flash[:notice] = t 'project.created'
      redirect_to @project
    else
      errors = ''
      @project.errors.full_messages.each do |msg|
        errors = errors + msg + ', '
      end
      flash[:error] = errors
      render 'new'
    end
  end

  def update
    respond_to do |format|
      format.html
    end
    if @project.update(project_params)
      flash[:notice] = t 'project.updated'
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    respond_to do |format|
      format.html
    end
    if @project.destroy
      flash[:notice] = t 'project.destroyed'
      redirect_to @project
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date, :sequence_num)
  end
end
