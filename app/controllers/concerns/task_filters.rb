# frozen_string_literal: true

# task filters
module TaskFilters
  def apply_filters(tasks, params)
    tasks = tasks.where(project_id: params[:project_id]) if params[:project_id].present?
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks = tasks.where(priority: params[:priority]) if params[:priority].present?
    tasks = tasks.where(assignable_id: params[:assignable_id]) if params[:assignable_id].present?
    tasks
  end
end
