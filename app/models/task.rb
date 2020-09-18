# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  STATUS = %w[Started Pending Completed].freeze
  PRIORITY = { low: 1, medium: 2, high: 3 }.freeze
  sequenceid :company, :tasks
  belongs_to :company, optional: true
  belongs_to :project, optional: true
  belongs_to :reviewer, class_name: 'User', optional: true
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :created_by, class_name: 'User', optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :tasks_watchers, dependent: :destroy
  has_many :watcher_users, through: :tasks_watchers, source: :watcher, source_type: 'User'
  has_many :watcher_teams, through: :tasks_watchers, source: :watcher, source_type: 'Team'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Task'
  belongs_to :parent, class_name: 'Task', optional: true

  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validate :validate_date
  validate :validate_expected_date

  def validate_date
    if :end_date.nil? && :start_date.nil? && :end_date < :start_date
      errors.add(:end_date, 'cannot be less than start date')
    end
  end

  def validate_expected_date
    if :expected_end_date.nil? && :expected_start_date.nil? && :expected_end_date < :expected_start_date
      errors.add(:expected_end_date, 'cannot be less than expected start date')
    end
  end
end
