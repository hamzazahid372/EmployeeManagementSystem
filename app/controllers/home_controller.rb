class HomeController < ApplicationController
  def index
    @projects = Current.user.projects
    @assigned_tasks = Current.user.assigned_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @watching_tasks = Current.user.watching_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @reviewing_tasks = Current.user.reviewing_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @created_tasks = Current.user.created_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @created_teams = Current.user.created_teams.includes(:created_by, :lead)
    @leading_teams = Current.user.leading_teams.includes(:created_by, :lead)

    @assigned_tasks_chartdata = @assigned_tasks.group(:status).count
    respond_to do |format|
      format.html
    end
  end
end
