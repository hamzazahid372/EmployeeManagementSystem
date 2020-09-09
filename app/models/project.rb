# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  belongs_to :company_id
  belongs_to :created_by, class_name: 'User'
  has_many :projects_departments
  has_many :departments, through: :projects_departments
  has_many :projects_users
  has_many :tasks
  has_many :users, through: :projects_users
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
end
