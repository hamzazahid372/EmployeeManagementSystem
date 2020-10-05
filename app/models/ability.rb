# frozen_string_literal: true

# define abilities
class Ability
  include CanCan::Ability
  include Abilities::TeamAbility
  include Abilities::UserAbility
  include Abilities::ProjectAbility
  include Abilities::EventAbility
  include Abilities::DepartmentAbility
  include Abilities::CommentAbility
  include Abilities::TaskAbility
  include Abilities::AttachmentAbility
  include Abilities::UserTeamAbility
  include Abilities::TimeLogAbility
  include Abilities::ProjectUserAbility
  include Abilities::HomeAbility
  include Abilities::ProjectDepartmentAbility
  include Abilities::TaskWatcherAbility
  include Abilities::CompanySettingAbility
  include Abilities::WorkingDayAbility

  def initialize(user)
    return unless user.present?

    if user.admin?
      define_team_abilities_for_admin(user)
      define_user_abilities_for_admin(user)
      define_project_abilities_for_admin(user)
      define_event_abilities_for_admin(user)
      define_department_abilities_for_admin(user)
      define_comment_abilities_for_admin(user)
      define_task_abilities_for_admin(user)
      define_attachment_abilities_for_admin(user)
      define_user_team_abilities_for_admin(user)
      define_time_log_abilities_for_admin(user)
      define_project_user_abilities_for_admin(user)
      define_home_user_abilities_for_admin(user)
      define_project_department_abilities_for_admin(user)
      define_task_watcher_abilities_for_admin(user)
      define_company_setting_abilities_for_admin(user)
      define_working_day_abilities_for_admin(user)
    else
      define_team_abilities_for_employee(user)
      define_user_abilities_for_employee(user)
      define_project_abilities_for_employee(user)
      define_event_abilities_for_employee(user)
      define_department_abilities_for_employee(user)
      define_comment_abilities_for_employee(user)
      define_task_abilities_for_employee(user)
      define_attachment_abilities_for_employee(user)
      define_user_team_abilities_for_employee(user)
      define_time_log_abilities_for_employee(user)
      define_project_user_abilities_for_employee(user)
      define_home_user_abilities_for_employee(user)
      define_project_department_abilities_for_employee(user)
      define_task_watcher_abilities_for_employee(user)
    end
  end
end
