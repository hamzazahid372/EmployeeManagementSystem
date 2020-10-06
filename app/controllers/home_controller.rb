# frozen_string_literal: true

# Home Controller
class HomeController < ApplicationController
  #Get root
  def index
    @projects = Current.user.projects
    @assigned_tasks = Current.user.assigned_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @watching_tasks = Current.user.watching_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @reviewing_tasks = Current.user.reviewing_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @created_tasks = Current.user.created_tasks.includes(:project, :assignee, :created_by, :reviewer)
    @created_teams = Current.user.created_teams.includes(:created_by, :lead)
    @leading_teams = Current.user.leading_teams.includes(:created_by, :lead)

    @assigned_tasks_piechart_data = @assigned_tasks.group(:status).count
    @watching_tasks_piechart_data = @watching_tasks.group(:status).count
    @created_tasks_piechart_data = @created_tasks.group(:status).count
    @reviewing_tasks_piechart_data = @reviewing_tasks.group(:status).count
    @tasks_timeline_data = Task.accessible_by(current_ability).order(start_date: :asc).pluck(:title, :start_date, :end_date)
    respond_to do |format|
      format.html
    end
  end
end
