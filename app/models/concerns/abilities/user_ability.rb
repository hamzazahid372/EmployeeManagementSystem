module Abilities
  module UserAbility
    def define_user_abilities_for_admin(user)
      can :manage, User, company_id: user.company_id
    end

    def define_user_abilities_for_employee(user)
      can %i[read search], User, company_id: user.company_id
    end
  end
end
