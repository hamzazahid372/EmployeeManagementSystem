module Abilities
  module TaskAbility
    def define_task_abilities_for_admin(user)
      can :manage, Task, company_id: user.company_id
      binding.pry
    end
    def define_task_abilities_for_employee(user)
      can :manage, Task
    end
  end
end
