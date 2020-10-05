# frozen_string_literal: true

# Company model
class Company < ApplicationRecord
  not_multitenant

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
  belongs_to :owner, class_name: 'User', optional: true
  has_one :company_setting
  has_many :working_days, dependent: :destroy
  has_many :holidays, dependent: :destroy
  
  after_create :create_dependents

  def create_dependents
    create_company_setting!
    create_working_days
  end

  def create_working_days
    WorkingDay.insert_all!([
      { company_id: id, day: 'Mon', off_day: false, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 'Tue', off_day: false, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now }, 
      { company_id: id, day: 'Wed', off_day: false, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now }, 
      { company_id: id, day: 'Thu', off_day: false, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now }, 
      { company_id: id, day: 'Fri', off_day: false, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now }, 
      { company_id: id, day: 'Sat', off_day: true, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 'Sun', off_day: true, from: "08:00AM", to: "04:00PM", created_at: Time.now, updated_at: Time.now } 
    ])
  end

  validates :name, uniqueness: true
  validates :subdomain, uniqueness: true
end
