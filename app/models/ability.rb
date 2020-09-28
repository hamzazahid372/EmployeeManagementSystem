<<<<<<< HEAD
# frozen_string_literal: true

# define abilities
class Ability
  include CanCan::Ability
  include Abilities::TeamAbility
=======
class Ability
  include CanCan::Ability
  include Abilities::UserAbility
  include Abilities::ProjectAbility

>>>>>>> 68afaea60580e7a46a4a4318ccdf1c87708f5444
  def initialize(user)
    return unless user.present?

    if user.admin?
<<<<<<< HEAD
      define_team_abilities_for_admin(user)
    else
      define_team_abilities_for_employee(user)
=======
      define_user_abilities_for_admin(user)
      define_project_abilities_for_admin(user)
    else
      define_user_abilities_for_employee(user)
      define_project_abilities_for_employee(user)
>>>>>>> 68afaea60580e7a46a4a4318ccdf1c87708f5444
    end
  end
end
