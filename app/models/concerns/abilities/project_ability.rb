module Abilities
  module ProjectAbility
    def define_project_abilities_for_admin(user)
      can :manage, Project, company_id: user.company_id
    end

    def define_project_abilities_for_employee(user)
      can %i[read search], Project, Project.joins(:projects_users).where(projects_users: { user_id: user.id }, company_id: user.company_id) do |project|
        project.users.where(id: user.id).any?
      end
    end
  end
end
