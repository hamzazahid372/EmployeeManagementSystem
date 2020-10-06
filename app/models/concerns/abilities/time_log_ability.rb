module Abilities
  module TimeLogAbility
    def define_time_log_abilities_for_admin(user)
      can :manage, TimeLog, company_id: user.company_id
    end

    def define_time_log_abilities_for_employee(user)
      can :manage, TimeLog, user_id: user.id, company_id: user.company_id
      can :read, TimeLog, company_id: user.company_id
    end
  end
end
