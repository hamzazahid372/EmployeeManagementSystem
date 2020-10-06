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

  validates :name, uniqueness: true
  validates :subdomain, uniqueness: true

  after_create :create_dependents

  def create_dependents
    create_company_setting!
    create_working_days
  end

  def create_working_days
    WorkingDay.insert_all!([
      { company_id: id, day: 0, off_day: true, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 1, off_day: false, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 2, off_day: false, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 3, off_day: false, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 4, off_day: false, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 5, off_day: false, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now },
      { company_id: id, day: 6, off_day: true, from: '08:00AM', to: '04:00PM', created_at: Time.now, updated_at: Time.now }
    ])
  end

  def holiday?(date)
    holidays.any? do |holiday|
      if holiday.every_year?
        holiday.day.month == date.month && holiday.day.day == date.day
      else
        holiday.day == date
      end
    end
  end

  def off_day?(date)
    working_days.find_by(day: date.wday).off_day?
  end
  
end
