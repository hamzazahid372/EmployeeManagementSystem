# frozen_string_literal: true

# task filters
module TaskFilters
  def apply_filters(tasks, params)
    tasks = tasks.where(project_id: params[:project_id]) if params[:project_id]
    binding.pry
    tasks = tasks.where(status: params[:status]) if params[:status]
    tasks = tasks.where(priority: params[:priority]) if params[:priority]
    tasks = tasks.where(assignable_id: params[:assignable_id]) if params[:assignable_id]
    tasks
  end
end
