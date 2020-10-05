module ReportsHelper
  def get_task_attribute_value(attribute, value)
    case attribute.to_sym
    when :priority
      Task::PRIORITY.key value.to_i
    when :project_id
      Project.find_by(id: value)&.name
    when :assignee_id, :reviewer_id
      User.find_by(id: value)&.name
    else
      value
    end
  end
  def get_task_attribute_name(attribute)
    if attribute == 'project_id'
      'Project'
    else
      attribute.titleize
    end
  end
end
