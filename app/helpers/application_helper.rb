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
      project: %w[comments documents projects_users tasks],
      team: %w[comments users],
      task: %w[comments time_logs documents watchers history],
      department: %w[department_projects]
    }
    resource_tabs[resource] || []
  end

  def get_card_classes
    if params[:action] == 'index' && params[:controller] != 'user_companies' && params[:controller] != 'guest'
      'container-fluid w-100 mt-4 pl-4 pr-4 pb-4'
    elsif params[:controller] == 'user_companies' || params[:action] == 'change_password'
      'container-fluid w-50 mt-5 pl-4 pr-4 pb-4'
    elsif params[:controller] == 'reports'
      'container-fluid w-100 mt-5 pl-4 pr-4 pb-4'
    else
      'container-fluid w-75 mt-4 pl-4 pr-4'
    end
  end

  def get_attendance_button
    if Current.user.current_attendance.login_time.nil?
      (link_to '', attendance_log_in_path, method: 'post', class: 'btn btn-light fas fa-arrow-right float-left m-1', id: 'attendance-btn', title: 'Attendance Log-in', data: { confirm: 'Are you sure to mark your attendance log-in time?' })
    elsif Current.user.current_attendance.logout_time.nil?
      (link_to '', attendance_log_out_path, method: 'post', class: 'btn btn-light fas fa-arrow-left float-left m-1', id: 'attendance-btn', title: 'Attendance Log-out', data: { confirm: 'Are you sure to mark your attendance log-out time?' })
    end
  end

  def get_piechart(tasks, tasks_piechart_data)
    if tasks.any?
      pie_chart tasks_piechart_data, label: 'Hello'
    else
      content_tag(:p, 'No Content')
    end
  end

  def boolean_value(value)
    value ? 'Yes' : 'No'
  end

  def get_business_hours
    Current.company.working_days.filter_map do |working_day|
      next if working_day.off_day?

      {
        daysOfWeek: [working_day.day],
        startTime: working_day.from.strftime("%H:%M"),
        endTime: working_day.to.strftime("%H:%M")
      }
    end
  end

  def get_attendances
    Current.user.current_month_attendances.filter_map do |attendance|
      next if attendance.off_day?

      {
        start: attendance.date,
        allDay: true,
        display: 'background',
        color: get_attendance_color(attendance)
      }
    end
  end

  def get_attendance_color(attendance)
    case attendance.status
    when Attendance::STATUS.fetch('Present')
      'green'
    when Attendance::STATUS.fetch('Absent')
      'red'
    when Attendance::STATUS.fetch('Holiday')
      'blue'
    when Attendance::STATUS.fetch('Leave')
      'yellow'
    end
  end
end
