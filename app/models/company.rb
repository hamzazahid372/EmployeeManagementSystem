# frozen_string_literal: true

# Company model
class Company < ApplicationRecord
  has_many :users
  has_many :teams
  has_many :users_teams
  has_many :tasks
  has_many :projects
  has_many :attendances
  has_many :departments
  has_many :projects_departments
  has_many :comments
  has_many :attachments
  has_many :time_logs
  has_many :events
  has_many :company_settings
  has_many :notifications
  belongs_to :users, foreign_key: 'owner_id'
end
