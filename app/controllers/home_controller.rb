class HomeController < ApplicationController
  def index
    @projects = Current.user.projects
    @assigned_tasks = Current.user.assigned_tasks
    @watching_tasks = Current.user.watching_tasks
    @reviewing_tasks = Current.user.reviewing_tasks
    @created_tasks = Current.user.created_tasks
    @created_teams = Current.user.created_teams
    @leading_teams = Current.user.leading_teams
    respond_to do |format|
      format.html
    end
  end
end
