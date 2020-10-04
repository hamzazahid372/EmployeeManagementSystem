module Abilities
  module WorkingDayAbility
    def define_working_day_abilities_for_admin(user)
      if user.account_owner?
        can :manage, WorkingDay, company_id: user.company_id
      else
        can :read, WorkingDay, company_id: user.company_id
      end
    end
  end
end
