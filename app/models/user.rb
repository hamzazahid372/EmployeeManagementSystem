# frozen_string_literal: true

# Users model
class User < ApplicationRecord
  sequenceid :company, :users
  ROLES = {
    'Administrator' => 1,
    'Employee' => 2
  }.freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  belongs_to :company, optional: true
  accepts_nested_attributes_for :company
  belongs_to :department, optional: true
  has_many :teams, through: :users_teams
  has_many :users_teams, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :created_comments, class_name: 'Comment', dependent: :destroy
  has_many :created_projects, class_name: 'Project', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :attendances, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :created_events, class_name: 'Event', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', as: :assignable, dependent: :nullify
  has_many :created_tasks, class_name: 'Task', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :created_teams, class_name: 'Team', dependent: :nullify, foreign_key: 'created_by_id'
  has_many :leading_teams, class_name: 'Team', dependent: :nullify, foreign_key: 'lead_id'
  has_many :reviewing_tasks, class_name: 'Task', dependent: :nullify, foreign_key: 'reviewer_id'
  has_many :tasks_watchers, as: :watcher, dependent: :destroy
  has_many :watching_tasks, through: :tasks_watchers, source: :task
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role_id, presence: true, format: { with: /\A\d+\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { scope: :company_id }

  def admin?
    role_id == User::ROLES.fetch('Administrator')
  end

  def account_owner?
    company.owner_id == id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  protected

  def confirmation_required?
    created_at < 7.days.ago
  end
end
