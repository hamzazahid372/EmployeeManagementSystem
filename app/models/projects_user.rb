# frozen_string_literal: true

# projectsusers model
class ProjectsUser < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :user
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :project_id }

  def can_destroy?
    tasks = project.tasks
    tasks_count = tasks.where(assignee_id: user_id)
                       .or(tasks.where(created_by_id: user_id)
                       .or(tasks.where(reviewer_id: user_id))).count
    errors.add(:base, I18n.t('users.cannot_destroy_due_to_dependent_tasks')) if tasks_count > 0
    errors.blank?
  end  
end
