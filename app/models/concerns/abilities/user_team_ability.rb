# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on team
  module UserTeamAbility
    def define_user_team_abilities_for_admin(user)
      can :manage, UsersTeam, company_id: user.company_id
    end

    def define_user_team_abilities_for_employee(user)
      can %i[read create], UsersTeam, company_id: user.company_id
      can :update, UsersTeam, created_by_id: user.id, company_id: user.company_id
    end
  end
end
