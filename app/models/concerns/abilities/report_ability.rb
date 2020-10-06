module Abilities
  module ReportAbility
    def define_report_abilities_for_admin(user)
      can %i[tasks time_logs attendance_report task_audits], :report
    end

    def define_report_abilities_for_employee(user)
      can %i[task_audits], :report
    end
  end
end
