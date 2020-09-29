# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on team
  module TeamAbility
    def define_team_abilities_for_admin(user)
      can :manage, Team, company_id: user.company_id
    end

    def define_team_abilities_for_employee(user)
      can %i[read create], Team, company_id: user.company_id
      can :update, Team, created_by_id: user.id, company_id: user.company_id
    end
  end
end
