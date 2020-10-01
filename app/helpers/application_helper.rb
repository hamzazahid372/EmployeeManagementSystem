module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-warning'
    end
  end

  def get_resource_tabs(resource)
    resource_tabs = {
      user: %w[comments],
      project: %w[comments projects_users],
      team: %w[comments users_teams],
      task: %w[comments time_logs]
    }
    resource_tabs[resource] || []
  end

  def get_card_classes
    if params[:action] == 'index'
      'container-fluid w-100 mt-4 pl-4 pr-4 pb-4'
    elsif params[:action] == 'find'
      'container-fluid w-50 mt-5 pl-4 pr-4 pb-4'
    else
      'container-fluid w-75 mt-4 pl-4 pr-4'
    end
  end
end
