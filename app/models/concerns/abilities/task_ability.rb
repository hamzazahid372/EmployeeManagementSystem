# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on task
  module TaskAbility
    def define_task_abilities_for_admin(user)
      can :manage, Task, company_id: user.company_id
    end

    def define_task_abilities_for_employee(user)
      can %i[read create], Task, Task.joins(project: :projects_users).where(projects_users: { user_id: user.id }, company_id: user.company_id) do |task|
        task.project.users.where(id: user.id).any?
      end
      can %i[update destroy], Task, created_by_id: user.id, company_id: user.company_id
    end
  end
end
