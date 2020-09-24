# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  STATUS = { 'Started' => 'started', 'Pending' => 'pending', 'Completed' => 'completed' }.freeze
  PRIORITY = { low: 1, medium: 2, high: 3 }.freeze
  sequenceid :company, :tasks
  belongs_to :company
  belongs_to :project
  belongs_to :reviewer, class_name: 'User', optional: true
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :created_by, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :tasks_watchers, dependent: :destroy
  has_many :watcher_users, through: :tasks_watchers, source: :watcher, source_type: 'User'
  has_many :watcher_teams, through: :tasks_watchers, source: :watcher, source_type: 'Team'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Task'
  belongs_to :parent, class_name: 'Task', optional: true

  validates :title, presence: true, length: { minimum: 3 }
  validate :validate_end_date
  validate :validate_expected_end_date
  validate :validate_due_date

  def validate_end_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, I18n.t('task.invalid_end_date'))
    end
  end

  def validate_expected_end_date
    if expected_end_date.present? && expected_start_date.present? && expected_end_date < expected_start_date
      errors.add(:expected_end_date, I18n.t('task.invalid_expected_end_date'))
    end
  end

  def validate_due_date
    if due_date.present? && start_date.present? && due_date < start_date
      errors.add(:due_date, I18n.t('task.invalid_due_date'))
    end
  end
end
