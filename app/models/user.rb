# frozen_string_literal: true

# Users model
class User < ApplicationRecord
  has_one :company
  belongs_to :company
  belongs_to :department
  has_one :team
  has_many :users_team
  has_many :tasks, through: :users_team
  has_many :tasks, as: :watcher
  has_many :projects
  has_many :attendances
  has_many :time_logs
  has_many :events
  has_many :attachments, as: :attachable
end
