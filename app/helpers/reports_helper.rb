module ReportsHelper
  def get_task_attribute_value(attribute, value)
    case attribute.to_sym
    when :priority
      Task::PRIORITY.key value.to_i
    when :project_id
      project = Project.find_by(id: value)
      project&.name
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
