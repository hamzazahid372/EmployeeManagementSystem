# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on team
  module TeamAbility
    def define_team_abilities_for_admin(user)
      can :manage, Team, company_id: user.company_id
    end

    def define_team_abilities_for_employee(user)
      can %i[read create], Team
      can :update, Team do |team|
        team.try(:user) == user
      end
      can :destroy, Team do |team|
        team.try(:user) == user
      end
    end
  end
end
