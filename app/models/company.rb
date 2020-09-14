# frozen_string_literal: true

# Company model
class Company < ApplicationRecord
  def self.current_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_id
    Thread.current[:company_id]
  end

  has_many :users, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :users_teams, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :projects_departments, dependent: :destroy
  has_many :projects_users, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :company_settings, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tasks_watchers, dependent: :destroy
  belongs_to :owner, class_name: 'User'
end
