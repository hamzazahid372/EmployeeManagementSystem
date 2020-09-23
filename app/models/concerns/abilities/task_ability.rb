# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on task
  module TaskAbility
    def define_task_abilities_for_admin(user)
      can :manage, Task, company_id: user.company_id
    end

    def define_task_abilities_for_employee(user)
      can %i[read create], Task, company_id: user.company_id
      can :update, Task, created_by_id: user.id, company_id: user.company_id
    end
  end
end
