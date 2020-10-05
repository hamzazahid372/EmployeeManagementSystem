# frozen_string_literal: true

# Abilities
module Abilities
  # Abilities on projects users
  module HomeAbility
    def define_home_user_abilities(user)
      can :index, :home
    end
  end
end
