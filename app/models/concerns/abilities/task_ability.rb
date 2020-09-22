# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on task
  module TaskAbility
    def define_task_abilities_for_admin(user)
      can :manage, Task, company_id: user.company_id
    end

    def define_task_abilities_for_employee(user)
      can %i[read create], Task
      can :update, Task do |task|
        task.try(:user) == user
      end
      can :destroy, Task do |task|
        task.try(:user) == user
      end
    end
  end
end
