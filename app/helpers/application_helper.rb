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
      project: %w[comments],
      team: %w[comments users_teams],
      task: %w[comments time_logs]
    }
    resource_tabs[resource] || []
  end
end
