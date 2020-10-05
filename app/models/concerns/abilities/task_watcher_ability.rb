# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on tasks watchers
  module TaskWatcherAbility
    def define_task_watcher_abilities_for_admin(user)
      can :manage, TasksWatcher, company_id: user.company_id
    end

    def define_task_watcher_abilities_for_employee(user)
      can %i[read], TasksWatcher, company_id: user.company_id
    end
  end
end
