# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on users teams
  module UserTeamAbility
    def define_user_team_abilities_for_admin(user)
      can :manage, UsersTeam, company_id: user.company_id
    end

    def define_user_team_abilities_for_employee(user)
      can %i[read], UsersTeam, company_id: user.company_id
    end
  end
end
