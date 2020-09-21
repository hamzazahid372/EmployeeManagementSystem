module Abilities
  module ProjectAbility
    def define_project_abilities_for_admin(user)
      can :manage, Project
      binding.pry
    end
    def define_project_abilities_for_employee(user)
      can :manage, Project
    end
  end
end
