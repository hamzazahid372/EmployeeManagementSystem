module Abilities
  module HolidayAbility
    def define_holiday_abilities_for_admin(user)
      if user.account_owner?
        can :manage, Holiday, company_id: user.company_id
      else
        can :read, Holiday, company_id: user.company_id
      end
    end
  end
end
