class Ability
  include CanCan::Ability
  include Abilities::ProjectAbility
  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, Project
      define_project_abilities_for_admin(user)
    else
      define_project_abilities_for_employee(user)
    end
  end
end
