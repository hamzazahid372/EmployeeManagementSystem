class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num
  def index
    @projects = Project.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @project.save
      flash[:notice] = 'Task created successfully'
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Task updated successfully'
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Task destroyed successfully'
      redirect_to @project
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date, :sequence_num)
  end
end
