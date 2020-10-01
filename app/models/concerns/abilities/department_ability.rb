module Abilities
  module DepartmentAbility
    def define_department_abilities_for_admin(user)
      can :manage, Department, company_id: user.company_id
    end

    def define_department_abilities_for_employee(user)
      can :read, Department, company_id: user.company_id
    end
  end
end
