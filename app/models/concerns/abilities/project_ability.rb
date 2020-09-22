module Abilities
  module ProjectAbility
    def define_project_abilities_for_admin(user)
      can :manage, Project, company_id: user.company_id
    end
    def define_project_abilities_for_employee(user)
      can :read, Project
    end
  end
end
