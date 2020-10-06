# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  STATUS = { 'New' => 'new', 'Started' => 'started', 'Pending' => 'pending', 'Completed' => 'completed', 'Closed' => 'closed' }.freeze

  sequenceid :company, :projects

  belongs_to :company
  belongs_to :created_by, class_name: 'User', optional: true
  has_many :projects_departments, dependent: :destroy
  has_many :departments, through: :projects_departments
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, format: { with: /\A[a-zA-Z]+\d/ }
  validates :start_date, presence: true
  validate :date_validate
  validate :expected_date_validate

  def can_destroy?
    tasks_count = tasks.count
    errors.add(:base, I18n.t('project.dependent_tasks', tasks_count: tasks_count)) if tasks_count > 0
    errors.blank?
  end

  def date_validate
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, 'cannot be less than start date')
    end
  end

  def expected_date_validate
    if expected_end_date.present? && expected_start_date.present? && expected_end_date < expected_start_date
      errors.add(:expected_end_date, 'cannot be less than  expected start date')
    end
  end

  def self.search q
    where('name like :q', q: "%#{q}%").map { |p| { id: p.id, name: p.name } }
  end
end
