class Ability
  include CanCan::Ability
  include Abilities::UserAbility
  include Abilities::ProjectAbility
  include Abilities::EventAbility

  def initialize(user)
    return unless user.present?

    if user.admin?
      define_user_abilities_for_admin(user)
      define_project_abilities_for_admin(user)
      define_event_abilities_for_admin(user)
    else
      define_user_abilities_for_employee(user)
      define_project_abilities_for_employee(user)
      define_event_abilities_for_employee(user)
    end
  end
end
