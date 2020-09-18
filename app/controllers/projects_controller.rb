class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Current.company.projects.build
  end

  def edit
    if Project.find_by id: params[:id]
      @project = Project.find(params[:id])
    else
      @project = Current.company.projects.build
      render 'new'
    end
  end

  def create
    @project = Current.company.projects.build(project_params)
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end
  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
      flash[:alert] = 'Project has updated'
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end
  private
  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date)
  end
end
