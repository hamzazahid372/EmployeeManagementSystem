# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  STATUS = %w[Started Pending Completed].freeze
  belongs_to :company
  belongs_to :created_by, class_name: 'User'
  has_many :projects_departments, dependent: :destroy
  has_many :departments, through: :projects_departments
  has_many :projects_users, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
end
