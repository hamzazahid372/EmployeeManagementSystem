# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :user, foreign_key: 'reviewer_id'
  belongs_to :watcher, polymorphic: true
  belongs_to :user, foreign_key: 'assigned_to_id' # confusion
  belongs_to :user, foreign_key: 'created_id'
  has_many :comments, as: :commentable
  has_many :time_logs
  has_many :attachments, as: :attachable
end
