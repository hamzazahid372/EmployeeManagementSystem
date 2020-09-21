class Ability
  include CanCan::Ability
  include Abilities::TaskAbility
  def initialize(user)
    return unless user.present?

    if user.admin?
      define_task_abilities_for_admin(user)
    else
      define_task_abilities_for_employee(user)
    end
  end
end
