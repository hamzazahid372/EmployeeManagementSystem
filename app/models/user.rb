# frozen_string_literal: true

# Users model
class User < ApplicationRecord
  ROLES = {
    'Administrator' => 1,
    'Employee' => 2
  }.freeze

  sequenceid :company, :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true
  belongs_to :department, optional: true
  has_many :teams, through: :users_teams
  has_many :users_teams, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :created_comments, class_name: 'Comment', dependent: :destroy
  has_many :created_projects, class_name: 'Project', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :attendances, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :created_events, class_name: 'Event', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: :nullify
  has_many :created_tasks, class_name: 'Task', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :created_teams, class_name: 'Team', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :leading_teams, class_name: 'Team', dependent: :nullify, foreign_key: 'lead_id'
  has_many :reviewing_tasks, class_name: 'Task', dependent: :nullify, foreign_key: 'reviewer_id'
  has_many :tasks_watchers, as: :watcher, dependent: :destroy
  has_many :watching_tasks, through: :tasks_watchers, source: :task
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users

  accepts_nested_attributes_for :company

  validates :first_name, presence: true, format: { with: /[a-zA-Z0-9]/ }
  validates :last_name, presence: true
  validates :role_id, presence: true, format: { with: /\A\d+\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { scope: :company_id }

  scope :admins, -> { where(role_id: ROLES['Administrator']) }

  def can_destroy?
    assigned_tasks_count = assigned_tasks.count
    reviewing_tasks_count = reviewing_tasks.count
    leading_teams_count = leading_teams.count
    errors.add(:base, I18n.t('users.assigned_tasks_error', assigned_tasks_count: assigned_tasks_count)) if assigned_tasks_count > 0
    errors.add(:base, I18n.t('users.reviewing_tasks_error', reviewing_tasks_count: reviewing_tasks_count)) if reviewing_tasks_count > 0
    errors.add(:base, I18n.t('users.leading_teams_error', leading_teams_count: leading_teams_count)) if leading_teams_count > 0
    errors.add(:base, I18n.t('users.account_owner_cannot_destroy')) if account_owner?
    errors.blank?
  end

  def self.search(q, options = {})
    users = where('first_name like :q or last_name like :q', q: "%#{q}%")
    if options[:only_admins]
      users = users.admins
    elsif options[:project_id].present?
      users = users.joins(:projects_users).where(projects_users: { project_id: options[:project_id] })
    end
    users
  end

  def self.find_for_authentication(warden_conditions)
    where(email: warden_conditions[:email]).first
  end

  def admin?
    role_id == User::ROLES.fetch('Administrator')
  end

  def current_attendance
    @current_attendance ||= attendances.find_or_create_by(date: Time.zone.now.to_date)
  end

  def account_owner?
    company.owner_id == id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    full_name
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def current_month_attendances
    attendances.where("date >= #{Date.today.beginning_of_month}")
  end

  protected

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
