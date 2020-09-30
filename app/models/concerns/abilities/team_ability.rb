# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on team
  module TeamAbility
    def define_team_abilities_for_admin(user)
      can :manage, Team, company_id: user.company_id
    end

    def define_team_abilities_for_employee(user)
      can %i[read], Team, company_id: user.company_id
    end
  end
end
