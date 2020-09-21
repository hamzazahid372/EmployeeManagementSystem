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
    success = true
    begin
        Project.transaction do
          @project.save!
        end
      rescue ActiveRecord::RecordInvalid
        success = false
      end
    if success

      redirect_to @project
    else
      render 'new'
    end
  end
  def update
    success = true
    begin
        Project.transaction do
          @project.update(project_params)
        end
      rescue Exception => e
        success = false
    end
    if success
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    success = true
    begin
        Project.transaction do
          @project.destroy
        end
      rescue ActiveRecord::RecordInvalid
        e.backtrace
      end
      if success
        redirect_to @project
      end
  end
  private
  def project_params
    params.require(:project).permit(:name, :description, :status, :start_date, :end_date, :expected_start_date, :expected_end_date, :sequence_num)
  end
end
