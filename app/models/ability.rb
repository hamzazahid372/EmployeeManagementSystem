# frozen_string_literal: true

# define abilities
class Ability
  include CanCan::Ability
  include Abilities::ProjectAbility
  include Abilities::TaskAbility

  def initialize(user)
    return unless user.present?

    if user.admin?
      define_project_abilities_for_admin(user)
      define_task_abilities_for_admin(user)
    else
      define_project_abilities_for_employee(user)
      define_task_abilities_for_employee(user)
    end
  end
end
