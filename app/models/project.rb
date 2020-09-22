# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  sequenceid :company, :projects
  STATUS = %w[Started Pending Completed].freeze
  belongs_to :company
  belongs_to :created_by, class_name: 'User', optional: true
  has_many :projects_departments, dependent: :destroy
  has_many :departments, through: :projects_departments
  has_many :projects_users, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :name, presence: true
  validate :date_validate
  validate :expected_date_validate
  validates :name, length: { minimum: 3 }
  def date_validate
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, 'cannot be less than start date')
    end
  end

  def expected_date_validate
    if expected_end_date.present? && expected_start_date.present? && expected_end_date < expected_start_date
      errors.add(:expected_end_date, 'cannot be less than start date')
    end
  end
end
