module Abilities
  module CompanySettingAbility
    def define_company_setting_abilities_for_admin(user)
      if user.account_owner?
        can :manage, CompanySetting, company_id: user.company_id
      else
        can :read, CompanySetting, company_id: user.company_id
      end
    end
  end
end
