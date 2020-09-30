# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on projects users
  module ProjectUserAbility
    def define_project_user_abilities_for_admin(user)
      can :manage, ProjectsUser, company_id: user.company_id
    end

    def define_projects_user_abilities_for_employee(user)
      can %i[read], ProjectsUser, company_id: user.company_id
    end
  end
end
