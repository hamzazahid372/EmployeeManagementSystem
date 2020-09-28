# frozen_string_literal: true

# define abilities
class Ability
  include CanCan::Ability
  include Abilities::UserAbility
  include Abilities::ProjectAbility
<<<<<<< HEAD
  include Abilities::DepartmentAbility
=======
  include Abilities::CommentAbility
>>>>>>> 7b54f5c29d56bdd453404701774ec899d3410106
  include Abilities::TaskAbility
  def initialize(user)
    return unless user.present?

    if user.admin?
      define_user_abilities_for_admin(user)
      define_project_abilities_for_admin(user)
      define_department_abilities_for_admin(user)
      define_comment_abilities_for_admin(user)
      define_task_abilities_for_admin(user)
    else
      define_user_abilities_for_employee(user)
      define_project_abilities_for_employee(user)
      define_department_abilities_for_employee(user)
      define_comment_abilities_for_employee(user)
      define_task_abilities_for_employee(user)
    end
  end
end
