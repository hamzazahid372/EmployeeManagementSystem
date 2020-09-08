# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  belongs_to :comapny_id
  belongs_to :user, forein_key: 'created_by_id'
  has_many :projects_departments
  has_many :departments, through: :projects_departments
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
end
