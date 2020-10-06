# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on projects departments
  module ProjectDepartmentAbility
    def define_project_department_abilities_for_admin(user)
      can :manage, ProjectsDepartment, company_id: user.company_id
    end

    def define_project_department_abilities_for_employee(user)
      can :read, ProjectsDepartment, company_id: user.company_id
    end
  end
end
