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
      user: %w[comments documents],
      project: %w[comments documents projects_users],
      team: %w[comments users],
      task: %w[comments time_logs documents watchers history],
      department: %w[department_projects]
    }
    resource_tabs[resource] || []
  end

  def get_card_classes
    if params[:action] == 'index' && params[:controller] != 'user_companies'
      'container-fluid w-100 mt-4 pl-4 pr-4 pb-4'
    elsif params[:controller] == 'user_companies'
      'container-fluid w-50 mt-5 pl-4 pr-4 pb-4'
    elsif params[:controller] == 'reports' && params[:action] == 'tasks'
      'container-fluid w-100 mt-5 pl-4 pr-4 pb-4'
    elsif params[:controller] == 'reports' && params[:action] == 'task_audits'
      'container-fluid w-100 mt-5 pl-4 pr-4 pb-4'
      elsif params[:controller] == 'reports' && params[:action] == 'attendance_report'
      'container-fluid w-100 mt-5 pl-4 pr-4 pb-4'
      elsif params[:controller] == 'reports' && params[:action] == 'time_logs'
      'container-fluid w-100 mt-5 pl-4 pr-4 pb-4'
    else
      'container-fluid w-75 mt-4 pl-4 pr-4'
    end
  end

  def get_attendance_button
    if Current.user.current_attendance.login_time.nil?
      (link_to '', attendance_log_in_path, method: 'post', class: 'btn btn-light fas fa-arrow-right float-left m-1', id: 'attendance-btn')
    elsif Current.user.current_attendance.logout_time.nil?
      (link_to '', attendance_log_out_path, method: 'post', class: 'btn btn-light fas fa-arrow-left float-left m-1', id: 'attendance-btn')
    end
  end
end
