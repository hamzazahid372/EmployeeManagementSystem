# frozen_string_literal: true

# define abilities
class Ability
  include CanCan::Ability
  include Abilities::TeamAbility
  def initialize(user)
    return unless user.present?

    if user.admin?
      define_team_abilities_for_admin(user)
    else
      define_team_abilities_for_employee(user)
    end
  end
end
