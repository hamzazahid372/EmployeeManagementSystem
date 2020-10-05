# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on team
  module TeamAbility
    def define_team_abilities_for_admin(user)
      can :manage, Team, company_id: user.company_id
    end

    def define_team_abilities_for_employee(user)
      can %i[read search], Team, Team.joins(:users_teams).where(users_teams: { user_id: user.id }, company_id: user.company_id) do |team|
        team.users.where(id: user.id).any?
      end
    end
  end
end
